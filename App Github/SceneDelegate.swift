//
//  SceneDelegate.swift
//  App Github
//
//  Created by Roman Matusewicz on 18/07/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit
import OAuthSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = MainTabController()
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
            guard let url = URLContexts.first?.url else {
                return
            }
            if url.host == "oauth" {
                OAuthSwift.handle(url: url)
            }
    }

}

