//
//  Album.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit


struct Album {
    
    let artistName: String
    let albumName: String
    let imgUrl: String
    let genre: [String]
    let releaseDate: String
    let copyright: String
    let url: String
    
    init(){
        artistName = "Loading.."
        albumName = "Loading.."
        imgUrl   = ""
        releaseDate   = ""
        copyright   = ""
        genre = []
        url = ""
        
    }
    
    init(artistName: String, albumName: String, imgUrl: String, releaseDate: String, copyright: String, genre : [String], url: String){
        self.artistName = artistName
        self.albumName = albumName
        self.imgUrl  = imgUrl
        self.releaseDate  = releaseDate
        self.copyright  = copyright
        self.genre  = genre
        self.url = url
      }
    
}
