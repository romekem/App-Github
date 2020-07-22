//
//  FeedGridCell.swift
//  App Github
//
//  Created by Roman Matusewicz on 19/07/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit

class FeedGridCell: UICollectionViewCell{
    // MARK: - Propierties
    var category: String?
    var value: String?{
        didSet{
            configure()
        }
    }
    
    private let categoryLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.text = "Username"
        return label
    }()
    
    private let infoLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Fullname"
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stack = UIStackView(arrangedSubviews: [categoryLabel, infoLabel])
        stack.axis = .vertical
        stack.spacing = 4
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: self.leftAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
       func configure(){
           guard let val = value else {return}
           categoryLabel.text = category
           infoLabel.text = val
    
       }
}
