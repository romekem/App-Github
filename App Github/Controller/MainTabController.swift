//
//  MainTabController.swift
//  App Github
//
//  Created by Roman Matusewicz on 18/07/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit
import OAuthSwift

class MainTabController: UITabBarController {
    // MARK: - Properties
    static let userCache = NSCache<AnyObject, AnyObject>()
    
    var user: User?{
        didSet{
            guard let nav = viewControllers?[0] as? UINavigationController else {return}
            guard let feed = nav.viewControllers.first as? FeedController else {return}
            feed.user = user
        }
    }
    // MARK: - API
    
    func autorizeUser(viewController: UIViewController){
        AuthService.shared.autorizeUser(viewController: viewController) { (result) in
            switch result {
            case .success(let (credential, _, _)):
                self.fetchUser()
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    func fetchUser(){
        if let cachedUser = MainTabController.userCache.object(forKey: "key" as AnyObject) as? User {
            self.user = cachedUser
            return
        }
        AuthService.shared.fethUser { (user) in
            self.user = user
            MainTabController.userCache.setObject(user, forKey: "key" as AnyObject)
        }
    }
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if AuthService.shared.oauthswift.client.credential.oauthToken == "" {

            DispatchQueue.main.async {

            let nav = UINavigationController(rootViewController: LoginController())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            }
        } else {
            fetchUser()
            configureViewControllers()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUser()
        configureViewControllers()

    }
    
    // MARK: - Helpers
    
    func configureViewControllers(){
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let img1 = UIImage(named: "activity_feed")
        let nav1 = templateNavigationController(image: img1, rootViewController: feed)
        
        let repo = RepoController()
        let img2 = UIImage(named: "documents")
        let nav2 = templateNavigationController(image: img2, rootViewController: repo)
    
        viewControllers = [nav1, nav2]
        
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
}
    

