//
//  Repository.swift
//  App Github
//
//  Created by Roman Matusewicz on 20/07/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Repository {
    let name: String
    let language: String
    let description: String
    let owner: String
    let priv: Bool
    var repoType: String
    
    var repoArray: [String]
    
    init(responseJSON: JSON) {
        self.name = responseJSON["name"].stringValue
        self.language = responseJSON["language"].stringValue
        self.description = responseJSON["description"].stringValue
        self.owner = responseJSON["owner"]["login"].stringValue
        self.priv = responseJSON["private"].boolValue
        
        self.repoType = self.priv ? "Private" : "Public"
        
        repoArray = [self.name, self.language, self.description, self.description, self.repoType]
    }
}
