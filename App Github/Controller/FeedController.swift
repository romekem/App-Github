//
//  FeedController.swift
//  App Github
//
//  Created by Roman Matusewicz on 19/07/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit

private let listCellIdentifier = "FeedListCell"
private let gridCellIdentifier = "FeedGridCell"
private let headerIdentifier = "FeedFilterHeader"

class FeedController: UICollectionViewController {
    // MARK: - Properties
    
    var user: User?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    private var isGridLayoutUsed = false {
        didSet{
            collectionView.reloadData()
            configureRightBarButton()
        }
    }
    
    private var isFilterUsed = false
    
    private var isUserEmpty: Bool {
        return user == nil
    }
    
    var filteredFeedDict = [String: String]()
    
    let userFeeds = UserFeeds()
    
    // MARK: - Selectors
    
    @objc func gridButtonTapped(){
        isGridLayoutUsed = true
    }
    
    @objc func listButtonTapped(){
        isGridLayoutUsed = false
    }
    
    // MARK: - API
    func fetchUser(){
        AuthService.shared.fethUser { (user) in
            self.user = user
        }
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
    super.viewDidLoad()
        configureCollectionView()
        configureRightBarButton()
        
        if user == nil {
            fetchUser()
        }
        
    }
    
    // MARK: - Helpers
    func configureCollectionView(){
        collectionView.register(FeedListCell.self, forCellWithReuseIdentifier: listCellIdentifier)
         collectionView.register(FeedGridCell.self, forCellWithReuseIdentifier: gridCellIdentifier)
         collectionView.register(FeedFilterHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)

         collectionView.backgroundColor = .white
    }
    
    func configureRightBarButton() {
        self.navigationItem.rightBarButtonItem = nil
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                
        let rightButton = UIButton()
        rightButton.setTitleColor(UIColor.darkGray, for: [])
        rightButton.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 60, height: 30))
                
        if isGridLayoutUsed {
            
            rightButton.setTitle("List", for: [])
            rightButton.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)
        } else {
            rightButton.setTitle("Grid", for: [])
            rightButton.addTarget(self, action: #selector(gridButtonTapped), for: .touchUpInside)
        }
                
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = rightButton
        self.navigationItem.rightBarButtonItem = rightBarButton

    }
}

    // MARK: - UICollectionViewDataSource/Delegate
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let user = user {
            return isFilterUsed ? filteredFeedDict.count : user.categoryArray.count
        } else {
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isGridLayoutUsed {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gridCellIdentifier, for: indexPath) as! FeedGridCell
            cell.category = isFilterUsed ? Array(filteredFeedDict.keys)[indexPath.row] : user?.categoryArray[indexPath.row]
            cell.value = isFilterUsed ? Array(filteredFeedDict.values)[indexPath.row] : user?.valueArray[indexPath.row]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCellIdentifier, for: indexPath) as! FeedListCell
            cell.category = isFilterUsed ? Array(filteredFeedDict.keys)[indexPath.row] : user?.categoryArray[indexPath.row]
            cell.value = isFilterUsed ? Array(filteredFeedDict.values)[indexPath.row] : user?.valueArray[indexPath.row]

            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! FeedFilterHeader
        header.delegate = self
        return header
    }
}
    // MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height1 = CGSize(width: 20, height: 0).height
        let height2 = CGSize(width: 20, height: 80).height
        let height = isUserEmpty ? height1 : height2

        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isGridLayoutUsed {
            let width = view.frame.width
            return CGSize(width: (width - 15)/2, height: (width - 15)/4)
        } else {
            return CGSize(width: view.frame.width, height: 30)
        }
    }
}
    // MARK: - FeedFilterHeaderDelegate
extension FeedController: FeedFilterHeaderDelegate{
    func showLogin() {
        guard let user = user else {return}
        let dictToFiltr =  userFeeds.convertModelToDictionary(user: user)
        filteredFeedDict = userFeeds.showLoginOnly(dictionary: dictToFiltr)
        isFilterUsed = true
        collectionView.reloadData()
    }
    
    func showRepos() {
        guard let user = user else {return}
        let dictToFiltr =  userFeeds.convertModelToDictionary(user: user)
        filteredFeedDict = userFeeds.showReposOnly(dictionary: dictToFiltr)
        isFilterUsed = true
        collectionView.reloadData()
    }
    
    func showAllFeeds() {
        isFilterUsed = false
        collectionView.reloadData()
    }
    
    func emptyFieldFilter() {
        guard let user = user else {return}
        let dictToFiltr =  userFeeds.convertModelToDictionary(user: user)
        filteredFeedDict = userFeeds.filterEmptyFields(dictionary: dictToFiltr)
        isFilterUsed = true
        collectionView.reloadData()
    }
    
    
}
