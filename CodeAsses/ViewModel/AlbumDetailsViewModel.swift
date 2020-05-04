//
//  AlbumDetailsViewModel.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 5/4/20.
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

// MARK: - view model for album detailed page

struct AlbumDetailsViewModel: AlbumEssentials, AlbumDetails{
    
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

