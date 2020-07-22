//
//  FeedFilterHeader.swift
//  App Github
//
//  Created by Roman Matusewicz on 21/07/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit

protocol FeedFilterHeaderDelegate: class {
    func emptyFieldFilter()
    func showAllFeeds()
    func showLogin()
    func showRepos()
}

class FeedFilterHeader: UICollectionReusableView {
    // MARK: - Properties
    weak var delegate: FeedFilterHeaderDelegate?
    
    private lazy var filterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .systemBlue
        btn.setTitle("Filter Empty Fields", for: .normal)
        btn.setDimensions(width: 150, height: 20)
        btn.addTarget(self, action: #selector(filterFeeds), for: .touchUpInside)
        return btn
    }()
    
    private lazy var showAllButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .systemBlue
        btn.setTitle("All", for: .normal)
        btn.setDimensions(width: 50, height: 20)
        btn.addTarget(self, action: #selector(showAllFeeds), for: .touchUpInside)
        return btn
    }()
    
    private lazy var showLoginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .systemBlue
        btn.setTitle("Login", for: .normal)
        btn.setDimensions(width: 50, height: 20)
        btn.addTarget(self, action: #selector(showLogin), for: .touchUpInside)
        return btn
    }()
    
    private lazy var showRepoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .systemBlue
        btn.setTitle("Repositories", for: .normal)
        btn.setDimensions(width: 100, height: 20)
        btn.addTarget(self, action: #selector(showRepos), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(showAllButton)
        showAllButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 8)
        
        addSubview(filterButton)
        filterButton.anchor(top: showAllButton.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(showLoginButton)
        showLoginButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 8)
        
        addSubview(showRepoButton)
        showRepoButton.anchor(top: showAllButton.bottomAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 8)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func showAllFeeds(){
        delegate?.showAllFeeds()
    }
    
    @objc func filterFeeds(){
        delegate?.emptyFieldFilter()
    }
    
    @objc func showLogin(){
        delegate?.showLogin()
    }
    
    @objc func showRepos(){
        delegate?.showRepos()
    }
    // MARK: - Helpers
}
