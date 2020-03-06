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

    override func setUp() {
        super.setUp()
        
    }

    override func tearDown() {
        super.tearDown()

    }
    
    func unitTest1(){
 
        let album = Album(artistName: "Lady Gaga", albumName: "Chromatica", imgUrl: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/cb/1d/32/cb1d32f1-9ce1-0fb4-839a-76c3cab243f1/20UMGIM15390.rgb.jpg/200x200bb.png", releaseDate: "2020-04-10", copyright: "℗ 2020 Interscope Records", genre: ["Pop","Music"], url: "https://music.apple.com/us/album/chromatica/1500951604?app=music")
               
                    
            if (album.artistName != "Lady Gaga"){
                XCTFail("artistName not set!")
            }
            
            if (album.albumName != "Chromatica"){
                XCTFail("albumName not set!")
            }
            
            if (album.url != "https://music.apple.com/us/album/chromatica/1500951604?app=music"){
                XCTFail("url not set!")
            }
            
            if (album.imgUrl != "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/cb/1d/32/cb1d32f1-9ce1-0fb4-839a-76c3cab243f1/20UMGIM15390.rgb.jpg/200x200bb.png"){
                XCTFail("imgUrl not set!")
            }
        
            if (album.genre != ["Pop","Music"]){
                XCTFail("genre not set!")
            }
            
            if (album.releaseDate != "2020-04-10"){
                XCTFail("releaseDate not set!")
            }
            
            if (album.copyright != "℗ 2020 Interscope Records"){
                XCTFail("copyright not set!")
            }
    }

    
    func testExample() {
        unitTest1()

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
