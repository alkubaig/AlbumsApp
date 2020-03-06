//
//  AlbumUnitTestCase.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 3/5/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest

//test Album Model
class AlbumUnitTestCase2: XCTestCase {
    
    func unitTest1(){
 
        let album = Album(artistName: "Lady Gaga", albumName: "Chromatica", imgUrl: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/cb/1d/32/cb1d32f1-9ce1-0fb4-839a-76c3cab243f1/20UMGIM15390.rgb.jpg/200x200bb.png", releaseDate: "2020-04-10", copyright: "℗ 2020 Interscope Records", genre: ["Pop","Music"], url: "https://music.apple.com/us/album/chromatica/1500951604?app=music")
               
            XCTAssertEqual(album.artistName, "Lady Gaga", "artistName not set!")
            XCTAssertEqual(album.albumName, "Chromatica", "albumName not set!")
            XCTAssertEqual(album.url, "https://music.apple.com/us/album/chromatica/1500951604?app=music", "url not set!")
            XCTAssertEqual(album.imgUrl, "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/cb/1d/32/cb1d32f1-9ce1-0fb4-839a-76c3cab243f1/20UMGIM15390.rgb.jpg/200x200bb.png", "imgUrl not set!")
            XCTAssertEqual(album.genre, ["Pop","Music"], "genre not set!")
            XCTAssertEqual(album.releaseDate, "2020-04-10", "releaseDate not set!")
            XCTAssertEqual(album.copyright, "℗ 2020 Interscope Records", "copyright not set!")
    }

    func testExample() {
        unitTest1()

    }
    

}
