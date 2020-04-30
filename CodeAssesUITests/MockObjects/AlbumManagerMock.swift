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
    
    func fetchAlbum(numAlbums: Int){
    }
}
