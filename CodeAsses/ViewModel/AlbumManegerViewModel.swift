//
//  AlbumsViewModel.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 5/4/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

// MARK: - Delegate methods for updating table after HTTP

//methods confirming to TableViewDelegateProtocol AlbumManagerDelegate

class AlbumManegerViewModel: NSObject, AlbumManagerDelegate {

    private var albumManager = AlbumManager()
    @objc dynamic var albums = [Album]() //observe albums
    
    override init(){
        super.init()
        
        //set albumManager delegate to self
        albumManager.delegate = self
    }
    
    //fetch albums by calling api
    func fetchAlbum(numAlbums: Int){
        //perfom api call
        albumManager.performRequest(with: Constants.fullAlbumURL)
    }
            
    // delegate method called with success
    func didLoadAlbum(albums: [Album]) {
        
        DispatchQueue.main.async {
            self.albums = albums
        }
    }
    
    // delegate method called with failing
    func didFailWithError(error: Error) {
        print(error)
    }
}
