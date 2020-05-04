//
//  Album.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation

// MARK: - api resuls with custom decoder

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

// MARK: - Album model with custom decoder

struct Genres : Codable {
    let name: String
}

//make album NSObject to observe it
class Album: NSObject,Decodable{

    let artistName: String
    let albumName: String
    let imgUrl: String
    let releaseDate: String
    let copyright: String
    let url: String
    let genres: [Genres]

    enum AlbumInfoKeys: String, CodingKey {
        case imgUrl = "artworkUrl100" //custom name is imgUrl
        case artistName
        case albumName = "name"  //custom name albumName
        case genres
        case releaseDate
        case copyright
        case url
    }
    
    //intializer because this is a class
    init(artistName: String, albumName: String,imgUrl: String,
         releaseDate: String, copyright: String, url: String, genres: [Genres] ) {
        self.artistName = artistName
        self.albumName = albumName
        self.imgUrl = imgUrl
        self.releaseDate = releaseDate
        self.copyright = copyright
        self.url = url
        self.genres = genres
    }
    
    //decoder for NS object
    required convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: AlbumInfoKeys.self)
        let artistName = try values.decode(String.self, forKey: .artistName)
        let albumName = try values.decode(String.self, forKey: .albumName)
        let imgUrl = try values.decode(String.self, forKey: .imgUrl)
        let releaseDate = try values.decode(String.self, forKey: .releaseDate)
        let copyright = try values.decode(String.self, forKey: .copyright)
        let url = try values.decode(String.self, forKey: .url)
        let genres = try values.decode([Genres].self, forKey: .genres)
         
        //calls intializer after decoding
        self.init(artistName:artistName,albumName:albumName,imgUrl:imgUrl,
                   releaseDate:releaseDate, copyright:copyright, url:url, genres:genres)
    }

}
