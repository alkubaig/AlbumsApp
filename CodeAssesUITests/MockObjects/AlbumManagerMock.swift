//
//  AlbumManagerMock.swift
//  CodeAssesUITests
//
//  Created by Ghadeer Alkubaish on 4/27/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation

enum NetworkErr: Error {
    case noData
    case statusCode(Int)
}

struct AlbumManagerMock: AlbumManagerProtocol {
    
    var delegate: AlbumManagerDelegate?
    let albums: [Album]
    var completion: (() -> Void)
    
    
    init(albums: [Album], complition: @escaping (()->Void)) {
        self.albums = albums
        self.completion = complition
    }
    
    func fetchAlbum(numAlbums: Int){
        delegate?.didLoadAlbum(albums: albums,completion: completion)
    }
}


