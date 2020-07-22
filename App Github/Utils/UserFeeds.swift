//
//  UserFeeds.swift
//  App Github
//
//  Created by Roman Matusewicz on 21/07/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import Foundation

struct UserFeeds {
    
    func convertModelToDictionary(user: User) -> [String:String] {
        var dictionary =  [String: String]()
        dictionary["Name"] = user.name
        dictionary["Login"] = user.login
        dictionary["Email"] = user.email
        dictionary["Location"] = user.location
        dictionary["Company"] = user.company
        dictionary["Followers"] = user.followers
        dictionary["Following"] = user.following
        dictionary["Public Repositories"] = user.publicRepos
        dictionary["Private Repositories"] = user.privateRepos
        
        if user.twitterUsername != "" && user.twitterUsername != nil {
            dictionary["Twitter Username"] = user.twitterUsername
        }
        return dictionary
    }
    
    func filterEmptyFields(dictionary: [String:String]) -> [String:String] {
        let filteredDict =  dictionary.filter { $0.value.count > 0 }
        return filteredDict
    }
    
    func showReposOnly(dictionary: [String:String]) -> [String:String] {
        let filteredDict =  dictionary.filter { $0.key.contains("Repositories") }
        return filteredDict
    }
    
    func showLoginOnly(dictionary: [String:String]) -> [String:String] {
        let filteredDict =  dictionary.filter { $0.key.contains("Login") }
        return filteredDict
    }
    
}
