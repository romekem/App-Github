//
//  RepoCell.swift
//  App Github
//
//  Created by Roman Matusewicz on 20/07/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell{
    // MARK: - Properties
    var repo: Repository? {
        didSet{
            configure()
        }
    }
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Username"
        return label
    }()
    
    private let languageLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.text = "Swift"
        return label
    }()
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameLabel)
        nameLabel.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 4, paddingLeft: 8)
        
        addSubview(languageLabel)
        languageLabel.anchor(top: nameLabel.bottomAnchor, left: self.leftAnchor, paddingTop: 2, paddingLeft: 8)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helpers
    
    func configure(){
        guard let repo = repo else {return}
        nameLabel.text = repo.name
        languageLabel.text = repo.language
    }
    
}
