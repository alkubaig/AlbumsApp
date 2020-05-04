//
//  AlbumCellViewModel.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 4/15/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

// MARK: - protocol for Album properties.

//album properties needed for album cells
protocol AlbumEssentials {
    
    var album: Album {set get}
    var artistName: String {get}
    var albumName: String {get}
    var imgUrl: String {get}
}

// MARK: - shared methods for AlbumEssentials protocol

extension AlbumEssentials {
    
    var artistName: String {
        return self.album.artistName
    }
    var imgUrl: String{
        return self.album.imgUrl
    }
    var albumName: String{
        return self.album.albumName
    }
}

// MARK: - view model for album cells

struct AlbumCellViewModel: AlbumEssentials {
    
    var album : Album
}

