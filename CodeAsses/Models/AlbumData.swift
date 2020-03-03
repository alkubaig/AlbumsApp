//
//  Album.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    let artistName: String
    let id: Int
    let name: String
    let artworkUrl100: String
    
}

struct Feed: Codable {
    let results: [Album]
}

struct AlbumData: Codable {
    let Feed: [Feed]
}

