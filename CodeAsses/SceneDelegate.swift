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
            
            //intilize the objects that AlbumTableViewController depends on.
            
            //1
            let albumManager = AlbumManager()
            //2
            let albumsListViewModel = [AlbumCellViewModel]()
            //3 use genetic class for table dataSorce
            let dataSource : TableViewDataSorce<AlbumTableViewCell, AlbumCellViewModel> = TableViewDataSorce(cellId:Constants.cellId, models: albumsListViewModel, configCell: {cell, vm in
                //dependency injuction - property
                   cell.albumViewModel = vm
               })
            
            // dependency (3) injuction - intilizer
            let tvc = AlbumTableViewController(albumManager: albumManager,
                                               albumsListViewModel:  albumsListViewModel,
                                               dataSource: dataSource)
            
            let navigation = UINavigationController(rootViewController: tvc)
            my_window.rootViewController = navigation

            self.window = my_window
            my_window.makeKeyAndVisible()
        }
    }

}



