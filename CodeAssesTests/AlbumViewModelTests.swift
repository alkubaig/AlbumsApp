//
//  AlbumViewModelTests.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 3/5/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest

class AlbumViewModelTests: XCTestCase {
    
    func testAlbumViewModel(){
        
        var res: Album?
        
        TestingFiles().getContentFromFile("Album","plist"){data in
        
            do {
               let decoder = PropertyListDecoder()
               res = try decoder.decode(Album.self, from: data)
               
           }catch{
               fatalError("decoder fail")
           }
        }

        guard let album = res else{
            fatalError("no album")
        }
        
        let albumMViewModel = AlbumDetailsViewModel(album: album)
        
        XCTAssertEqual(album.artistName, albumMViewModel.artistName, "artistName not set!")
        XCTAssertEqual(album.albumName, albumMViewModel.albumName, "albumName not set!")
        XCTAssertEqual(album.url, albumMViewModel.url, "url not set!")
        XCTAssertEqual(album.imgUrl, albumMViewModel.imgUrl, "imgUrl not set!")
        XCTAssertEqual(album.releaseDate, albumMViewModel.releaseDate, "releaseDate not set!")
        XCTAssertEqual(album.copyright, albumMViewModel.copyright, "copyright not set!")
        
        let genres = album.genres.map({$0.name}).joined(separator:"\n")
        (XCTAssertEqual(genres, albumMViewModel.genre, "genre not set!"))
        
    }
}
