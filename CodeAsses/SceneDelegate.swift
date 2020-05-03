//
//  SceneDelegate.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
         if let windowScene = scene as? UIWindowScene {

            let my_window = UIWindow(windowScene: windowScene)
                        
            let tvc = AlbumTableViewController()
            
            let navigation = UINavigationController(rootViewController: tvc)
            my_window.rootViewController = navigation

            self.window = my_window
            my_window.makeKeyAndVisible()
        }
    }

}



