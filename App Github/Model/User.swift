//
//  User.swift
//  App Github
//
//  Created by Roman Matusewicz on 19/07/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    var name: String
    var login: String
    let email: String
    let location: String
    let company: String
    let uid: String
    var followers: String
    var following: String
    let publicRepos: String
    let privateRepos: String
    var oauthToken: String
    var twitterUsername: String?
    var bio: String?
    
    var categoryArray = ["Login", "Email", "Name", "Location", "Company", "Followers", "Following", "Public Repositories", "Private Repositories"]
    var valueArray = [String]()
    
    var instances = 0
    
    init(oauthToken : String, responseJSON: JSON) {
        self.name = responseJSON["name"].stringValue
        self.login = responseJSON["login"].stringValue
        self.email = responseJSON["email"].stringValue
        self.company = responseJSON["company"].stringValue
        self.location = responseJSON["location"].stringValue
        self.uid = responseJSON["uid"].stringValue
        self.followers = responseJSON["followers"].stringValue
        self.following = responseJSON["following"].stringValue
        self.publicRepos = responseJSON["public_repos"].stringValue
        self.privateRepos = responseJSON["owned_private_repos"].stringValue
        self.oauthToken = oauthToken
        
        self.valueArray = [self.login, self.email, self.name, self.location, self.company, self.followers, self.following, self.publicRepos, self.privateRepos]
        
        if let twitterUsername = responseJSON["twitter_username"].string {
            self.twitterUsername = twitterUsername
            categoryArray.append("Twitter Usernam")
            valueArray.append(twitterUsername)
        }
        

    }
}

