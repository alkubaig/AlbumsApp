//
//  AlbumViewModels.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 4/15/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

// MARK: - protocol for Album properties.

//extra album properties needed for album detailed page
protocol AlbumDetails {
    
    var releaseDate: String {get}
    var copyright: String {get}
    var url: String {get}
    var genres: String {get}
}

//album properties needed for album cells
protocol AlbumEssentials {
    
    var album: Album {set get}
    var artistName: String {get}
    var albumName: String {get}
    var imgUrl: String {get}
}

// MARK: - default methods for AlbumEssentials protocol

extension AlbumEssentials {
    
    var artistName: String {
//        return "\(self.album.artistName) \(self.album.artistName)"
        return self.album.artistName

    }
    var imgUrl: String{
        return self.album.imgUrl
    }
    var albumName: String{
//        return "\(self.album.albumName) \(self.album.albumName)"
        return self.album.albumName
    }
}

// MARK: - view model for album cells

struct AlbumCellViewModel: AlbumEssentials {
    
    var album : Album
}

// MARK: - view model for album detailed page

struct AlbumDetailsViewModel : AlbumEssentials, AlbumDetails{
    
    var album : Album

    var releaseDate: String{
        return self.album.releaseDate
    }
    var copyright: String{
        return self.album.copyright
    }
    var url: String{
        return self.album.url
    }
    var genres: String{
        return self.album.genres.map({$0.name}).joined(separator:"\n")
    }
}
