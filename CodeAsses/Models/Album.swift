//
//  Album.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation



// MARK: - api resuls with custom decodable

struct AlbumsData {
   
    var albumsData : [Album]?
    
    enum CodingKeys: String, CodingKey {
          case resultsCodingKeys = "feed"
    }
    enum ResultsCodingKeys: String, CodingKey {
          case albumInfoKeys = "results"
    }
}

extension AlbumsData: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let additionalInfo = try values.nestedContainer(keyedBy: ResultsCodingKeys.self, forKey: .resultsCodingKeys)
        albumsData = try additionalInfo.decode([Album].self, forKey: .albumInfoKeys)
    }
    
}

// MARK: - Album model with custom decodable

struct Genres : Codable {
    let name: String
}

struct Album {

    let artistName: String
    let albumName: String
    var imgUrl: String
    let releaseDate: String
    let copyright: String
    let url: String
    let genres: [Genres]

    
    enum AlbumInfoKeys: String, CodingKey {
        case imgUrl = "artworkUrl100"
        case artistName
        case albumName = "name"
        case genres
        case releaseDate
        case copyright
        case url
    }
}

extension Album: Decodable {
    init(from decoder: Decoder) throws {
       let values = try decoder.container(keyedBy: AlbumInfoKeys.self)
        artistName = try values.decode(String.self, forKey: .artistName)
        albumName = try values.decode(String.self, forKey: .albumName)
        imgUrl = try values.decode(String.self, forKey: .imgUrl)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        copyright = try values.decode(String.self, forKey: .copyright)
        url = try values.decode(String.self, forKey: .url)
        genres = try values.decode([Genres].self, forKey: .genres)
    }
}
