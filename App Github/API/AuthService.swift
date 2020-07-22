//
//  AuthService.swift
//  App Github
//
//  Created by Roman Matusewicz on 19/07/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import Foundation
import OAuthSwift
import Alamofire
import SwiftyJSON

struct AuthService {
    
    static let shared = AuthService()
    
    let oauthswift = OAuth2Swift(
      consumerKey: "211e9e5505525229e744",
      consumerSecret: "7638c84620cd1ed9b5566e06d525b73b3a68f8b5",
      authorizeUrl: "https://github.com/login/oauth/authorize",
      accessTokenUrl: "https://github.com/login/oauth/access_token",
      responseType: "code"
    )
    
    func autorizeUser(viewController: UIViewController, completion: @escaping OAuth2Swift.TokenCompletionHandler){
        oauthswift.accessTokenBasicAuthentification = true
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: viewController, oauthSwift: oauthswift)
        let state = generateState(withLength: 20)
        let callbackURL = URL(string: "myoauthapp://oauth/callback")
        let scope = "user, repo"
        
        let parameters = ["verbose" : true,
                          "secret_in_body": true]

        oauthswift.authorize(withCallbackURL: callbackURL, scope: scope, state: state, parameters: parameters, completionHandler: completion)
    }
    
    func fethUser(completion: @escaping(User) -> Void){
        let url = REF_GIT_USER
        let token = oauthswift.client.credential.oauthToken
        let header: HTTPHeaders = ["Authorization": "token " + token]
        AF.request(url, method: .get, headers: header).responseJSON { (response) in
            guard let responseData = response.data else {return}
             
            let responseJSON: JSON = JSON(responseData)
            
            let user = User(oauthToken: token, responseJSON: responseJSON)
            completion(user)
            
        }
    }
    
    func fetchRepositories(completion: @escaping([Repository]) -> Void){
        let url = REF_GIT_REPOS
        let token = oauthswift.client.credential.oauthToken
        let header: HTTPHeaders = ["Authorization": "token " + token]
        AF.request(url, method: .get, headers: header).responseJSON { (response) in
            guard let responseData = response.data else {return}
             
            let responseJSON: JSON = JSON(responseData)
            guard let reposQuantity = responseJSON.array?.count else {return}
            var repos = [Repository]()
            
            for i in 0...reposQuantity-1{
                let repo = Repository(responseJSON: responseJSON[i])
                repos.append(repo)
            }
             completion(repos)
        }
    }
    
    func searchUserRepositories(searchText: String, completion: @escaping([Repository]) -> Void){
        let url = "https://api.github.com/search/repositories?q=" + searchText
        AF.request(url, method: .get).responseJSON { (response) in
            guard let responseData = response.data else {return}
            let responseJSON: JSON = JSON(responseData)
            print(responseJSON["items"])
            
            guard let reposQuantity = responseJSON["items"].array?.count else {return}
            print("DEBUG: \(reposQuantity)")
            var repos = [Repository]()
            
            if reposQuantity == 1 {
                let repo = Repository(responseJSON: responseJSON["items"][0])
                repos.append(repo)
                completion(repos)
            } else if reposQuantity > 1 {
                for i in 0...reposQuantity-1{
                    let repo = Repository(responseJSON: responseJSON["items"][i])
                    repos.append(repo)
                }
                completion(repos)
            } else if reposQuantity == 0 {
                print("No results.")
            }

             
        }
    }
}
        


