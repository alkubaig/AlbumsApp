//
//  AlbumViewModel.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/12/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

struct AlbumViewModel{
    
    var album : Album
    
    var artistName: String {
        return self.album.artistName
    }
    var imgData: Data?{
        if let url = URL(string: self.album.imgUrl){
            return try? Data(contentsOf: url)
        }
        return nil
    }
    var albumName: String{
        return self.album.albumName
    }
    var releaseDate: String{
        return self.album.releaseDate
    }
    var copyright: String{
        return self.album.copyright
    }
    var url: String{
        return self.album.url
    }
    var genre: String{
        return self.album.genre.joined(separator:"\n")
    }
    
}
