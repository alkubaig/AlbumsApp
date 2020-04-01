//
//  Album.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation

// Codable which is to use for parsing Json Objects of Albums.

struct Genres : Codable {
    let name: String
}

struct AlbumData: Codable {
    let artistName: String
    let name: String
    let artworkUrl100: String
    let genres: [Genres]
    let releaseDate: String
    let copyright: String
    let url: String
}

struct Res: Codable {
    let results: [AlbumData]
}

struct AlbumsData: Codable {
    let feed: Res
}

