//
//  DetailController.swift
//  App Github
//
//  Created by Roman Matusewicz on 21/07/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    // MARK: - Properties
    var repository: Repository?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 1
        return label
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.numberOfLines = 1
        return label
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 1
        return label
    }()
    
    private let repoTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 1
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - API
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        
        view.addSubview(nameLabel)
        nameLabel.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 12)
        
        view.addSubview(ownerLabel)
        ownerLabel.anchor(top: nameLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: 10, paddingLeft: 8)
        
        view.addSubview(languageLabel)
        languageLabel.centerX(inView: view, topAnchor: nameLabel.bottomAnchor, paddingTop: 10)
        
        view.addSubview(repoTypeLabel)
        repoTypeLabel.anchor(top: nameLabel.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingRight: 8)
        
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: ownerLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: 10, paddingLeft: 8)
        descriptionLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 8).isActive = true
        
        guard let repo = repository else {return}
        
        nameLabel.text = repo.name
        ownerLabel.text = repo.owner
        languageLabel.text = repo.language
        repoTypeLabel.text = repo.repoType
        descriptionLabel.text = repo.description
    }
}

