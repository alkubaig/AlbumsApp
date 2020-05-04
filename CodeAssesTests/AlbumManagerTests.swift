//
//  AlbumUnitTestCase.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 3/5/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest

/****************************************
 ** AlbumManager testing
 ** Test if parseJSON parses api result correctly
 ** Test custom decoder
****************************************/

class AlbumManagerTests: XCTestCase {
    
    // "ApiAlbums.json" simulates an example api json response with 3 albumns
    func testParseJSON_ApiAlbumsArray(){
        
        // get testing albums from "Albums.plist"
        let matchingAlbum = TestingAlbums.testingAlbums.getTestingAlbums

        //get valid api response from json file with valid albums
        // pass it to parseJSON
        parseJsonFileWithParseJSON(fileName: TestFileNames.apiAlbumsFileName){ result in
            
            XCTAssertEqual(result.count, TestingAlbums.testingAlbumsCount, "Missing some Albums!")
            
            for i in 0..<result.count{
                //comapre results from parseJSON with result from "Albums.plist"
               compareTwoAlbums(a: result[i], b: matchingAlbum[i])
           }
        }
    }
    
    // "ApiNoAlbums.json" file simulates an example api json response with no albums
    func testParseJSON_ApiEmptyAlbumsArray(){
        
        //get valid api response from json file with no albums
        // pass it to parseJSON
        parseJsonFileWithParseJSON(fileName: TestFileNames.apiNoAlbumsFileName){ result in

            XCTAssertEqual(result.count, 0, "This should be empty")
        }
    }
}

//MARK: - methods for testing

extension AlbumManagerTests{
    
    // get api result from json file and parse it through maneger method parseJSON
      func parseJsonFileWithParseJSON(fileName: String, testFunc: (_ result: [Album])->Void){
          
          TestingFiles.getContentFromFile(fileName,nil){data in
               
            //completion block calls parseJSON
            if let result = AlbumManager().parseJSON(data){
              testFunc(result)
            }else{
              XCTFail("parseJSON could not parse data!")
            }
          }
      }
    
    //compare two albums
    func compareTwoAlbums(a: Album, b: Album){
        
        XCTAssertEqual(a.artistName, b.artistName, "artistName not encoded correctly!")
        XCTAssertEqual(a.albumName, b.albumName, "albumName not encoded correctly!")
        XCTAssertEqual(a.url, b.url, "url not encoded correctly!")
        XCTAssertEqual(a.imgUrl, b.imgUrl, "imgUrl not encoded correctly!")
        XCTAssertEqual(a.genres.map({$0.name}), b.genres.map({$0.name}), "genre not encoded correctly!")
        XCTAssertEqual(a.releaseDate, b.releaseDate, "releaseDate not encoded correctly!")
        XCTAssertEqual(a.copyright, b.copyright, "copyright not encoded correctly!")

    }
}
