//
//  AlbumUnitTestCase.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 3/5/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest

//test AlbumManager Model
class AlbumManagerTests: XCTestCase {

    var albumMng = AlbumManager()
}
//MARK: -  test set 1 - if parseJSON parses json object correctly

extension AlbumManagerTests{
    
    // MARK: - ApiAlbums file simulates an example api json response with 3 albumns
    
    func testUnitTest1_1(){
        
        let matchingAlbum = TestingFiles().getMatchingAlbum()

        jsonFromFile(fileName: "ApiAlbums.json"){ result in
            
            XCTAssertEqual(result.count, 3, "Missing some Albums!")
            
            for i in 0..<result.count{
               compareAlbums(a: result[i], b: matchingAlbum[i])
           }
        }
        
    }
    
    // MARK: - ApiAlbums file simulates an example api json response with no albums

    func testUnitTest1_2(){
        
        jsonFromFile(fileName: "ApiNoAlbums.json"){ result in

            XCTAssertEqual(result.count, 0, "This should be empty")
        }
    }
    
}

extension AlbumManagerTests{
    

    // get api result from json file and parse it through maneger method
      func jsonFromFile(fileName: String, testFunc: (_ result: [Album])->Void){
          
          TestingFiles().getContentFromFile(fileName,nil){data in
               
               if let result = albumMng.parseJSON(data){
                  testFunc(result)
              }else{
                  fatalError("data can not be parsed!")
              }
          }
      }
    
    //compare two albums
    func compareAlbums(a: Album, b: Album){
        
        XCTAssertEqual(a.artistName, b.artistName, "artistName not encoded correctly!")
        XCTAssertEqual(a.albumName, b.albumName, "albumName not encoded correctly!")
        XCTAssertEqual(a.url, b.url, "url not encoded correctly!")
        XCTAssertEqual(a.imgUrl, b.imgUrl, "imgUrl not encoded correctly!")
        XCTAssertEqual(a.genres.map({$0.name}), b.genres.map({$0.name}), "genre not encoded correctly!")
        XCTAssertEqual(a.releaseDate, b.releaseDate, "releaseDate not encoded correctly!")
        XCTAssertEqual(a.copyright, b.copyright, "copyright not encoded correctly!")

    }
    
}

//MARK: -  test set 2 - if performRequest performs the correct response using a mock delegate object


extension AlbumManagerTests{

    //MARK: - (2.1) test with a valid url
    func testUnitTest2_1(){
                    
            let albumsExpectation = expectation(description: "AlbumAPI trying to retrieve new albums")

            let expectedBehaviorForDidLoadAlbum : (([Album]) -> Void) = { album in
            XCTAssertGreaterThanOrEqual(album.count,0)
                albumsExpectation.fulfill()
             }
            
            let expectedBehaviorFordidFailWithError : ((Error) -> Void) = { _ in
                XCTFail("This api should not fail")
                albumsExpectation.fulfill()
            }
            
            let albumManagerReceiverMock = AlbumManagerReceiverMock(expectedBehaviorForDidLoadAlbum ,expectedBehaviorFordidFailWithError)
            albumMng.delegate = albumManagerReceiverMock

            albumMng.fetchAlbum(numAlbums: 100)

            waitForExpectations(timeout: 1.0)
      }
    
    
    //MARK: - (2.2) test with an invalid url
     func testUnitTest2_2(){
        
        let albumsExpectation = expectation(description: "AlbumAPI trying to retrieve new albums")

        let expectedBehaviorForDidLoadAlbum : (([Album]) -> Void) = { album in
            XCTFail("This api should fail")
            albumsExpectation.fulfill()
         }
        
        let expectedBehaviorFordidFailWithError : ((Error) -> Void) = { _ in
            albumsExpectation.fulfill()
        }
        
        let albumManagerReceiverMock = AlbumManagerReceiverMock(expectedBehaviorForDidLoadAlbum ,expectedBehaviorFordidFailWithError)
        albumMng.delegate = albumManagerReceiverMock

        albumMng.performRequest(with: "PLAPLA")

        waitForExpectations(timeout: 1.0)
        
    }
    
}

