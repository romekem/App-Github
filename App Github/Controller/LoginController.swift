//
//  LoginController.swift
//  App Github
//
//  Created by Roman Matusewicz on 19/07/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//
import UIKit

class LoginController: UIViewController {
    // MARK: - Properties
    
    var isUserAutorized = false {
        didSet{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private let welcomeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.darkGray
        label.text = "Welcome!"
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .darkGray
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Log In", for: .normal)
        btn.setDimensions(width: 80, height: 30)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - API
    func autorizeUser(viewController: UIViewController){
        AuthService.shared.autorizeUser(viewController: viewController) { (result) in
            switch result {
            case .success(let (credential, _, _)):
                self.isUserAutorized = true

            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleLogin(){
        autorizeUser(viewController: self)
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(welcomeLabel)
        welcomeLabel.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 100)
        
        view.addSubview(loginButton)
        loginButton.center(inView: view)
    }
}
