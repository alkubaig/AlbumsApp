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
****************************************/

class AlbumManagerTests: XCTestCase {

    var albumMng = AlbumManager()
}
//MARK: -  test set 1

/****************************************
 ** test if parseJSON parses api result correctly
****************************************/

extension AlbumManagerTests{
    
    // "ApiAlbums.json" simulates an example api json response with 3 albumns
    func testUnitTest1_1(){
        
        // get testing albums from "Albums.plist"
        let matchingAlbum = TestingFiles.getMatchingAlbums()

        parseJsonFileWithParseJSON(fileName: "ApiAlbums.json"){ result in
            
            XCTAssertEqual(result.count, 3, "Missing some Albums!")
            
            for i in 0..<result.count{
                //comapre results from parseJSON with result from "Albums.plist"
               compareTwoAlbums(a: result[i], b: matchingAlbum[i])
           }
        }
    }
    
    // "ApiNoAlbums.json" file simulates an example api json response with no albums
    func testUnitTest1_2(){
        
        parseJsonFileWithParseJSON(fileName: "ApiNoAlbums.json"){ result in

            XCTAssertEqual(result.count, 0, "This should be empty")
        }
    }
    
}

// methods for testing set 1
extension AlbumManagerTests{
    
    // get api result from json file and parse it through maneger method
      func parseJsonFileWithParseJSON(fileName: String, testFunc: (_ result: [Album])->Void){
          
          TestingFiles.getContentFromFile(fileName,nil){data in
               
               if let result = albumMng.parseJSON(data){
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

//MARK: -  test set 2

/****************************************
 ** test if performRequest performs the correct response
 ** using a mock delegate object
****************************************/

enum NetworkErr: Error {
    case noData
    case statusCode(Int)
}

extension AlbumManagerTests{
    // (2.1) test with a valid response
    func testUnitTest2_1(){
        
        //testing delegate method 1
        let expectedBehaviorForDidLoadAlbum : (([Album]) -> Void) = { album in
            XCTAssertGreaterThanOrEqual(album.count,0)
         }
        
        //testing delegate method 2
        let expectedBehaviorFordidFailWithError : ((Error) -> Void) = { _ in
            XCTFail("This api should not fail")
        }
        //mock object with a testing closure for each delegate method
        let albumManagerReceiverMock =
            AlbumManagerReceiverMock(expectedBehaviorForDidLoadAlbum,
                                     expectedBehaviorFordidFailWithError)
        
        albumMng.delegate = albumManagerReceiverMock
        
        TestingFiles.getContentFromFile(TestFileNames.apiAlbums, nil) { (data) in
            albumMng.performRequest_(data: data, error: nil)
        }

        TestingFiles.getContentFromFile(TestFileNames.apiNoAlbums, nil) { (data) in
            albumMng.performRequest_(data: data, error: nil)
        }
    }
    
    // (3.2) test with an invalid response
    func testUnitTest2_2(){

       //testing delegate method 1
       let expectedBehaviorForDidLoadAlbum : (([Album]) -> Void) = { _ in
           XCTFail("This api should fail")
        }
       
       //mock object with a testing closure for each delegate method
       let albumManagerReceiverMock =
        AlbumManagerReceiverMock(expectedBehaviorForDidLoadAlbum ,{_ in})
       albumMng.delegate = albumManagerReceiverMock

        TestingFiles.getContentFromFile(TestFileNames.apiNoAlbums, nil) { (data) in
            albumMng.performRequest_(data: data, error: NetworkErr.noData)
            }
       }
}


//MARK: -  test set 3

/****************************************
 ** test if performRequest performs the correct response
 ** using a mock delegate object
 ** Set 2 is a better way to test this functionality to avoid doing http calls in testing, but
 ** I left it for demonstration
****************************************/

extension AlbumManagerTests{

    // (3.1) test with a valid url
    func testUnitTest3_1(){
        
        //use expectation to wait for api call to finish before testing
        let albumsExpectation = expectation(description: "AlbumAPI trying to retrieve new albums")

        //testing delegate method 1
        let expectedBehaviorForDidLoadAlbum : (([Album]) -> Void) = { album in
            XCTAssertGreaterThanOrEqual(album.count,0)
            albumsExpectation.fulfill()
         }
        
        //testing delegate method 2
        let expectedBehaviorFordidFailWithError : ((Error) -> Void) = { _ in
            XCTFail("This api should not fail")
            albumsExpectation.fulfill()
        }
        //mock object with a testing closure for each delegate method
        let albumManagerReceiverMock =
            AlbumManagerReceiverMock(expectedBehaviorForDidLoadAlbum,
                                     expectedBehaviorFordidFailWithError)
        albumMng.delegate = albumManagerReceiverMock

        //make api call
        albumMng.fetchAlbum(numAlbums: 100)

        waitForExpectations(timeout: 1.0)
      }
    
    
    // (3.2) test with an invalid url
     func testUnitTest3_2(){
        
        let albumsExpectation = expectation(description: "AlbumAPI trying to retrieve new albums")

        //testing delegate method 1
        let expectedBehaviorForDidLoadAlbum : (([Album]) -> Void) = { album in
            XCTFail("This api should fail")
            albumsExpectation.fulfill()
         }
        
        //testing delegate method 2
        let expectedBehaviorFordidFailWithError : ((Error) -> Void) = { _ in
            albumsExpectation.fulfill()
        }
        
        //mock object with a testing closure for each delegate method
        let albumManagerReceiverMock =
            AlbumManagerReceiverMock(expectedBehaviorForDidLoadAlbum,
                expectedBehaviorFordidFailWithError)
        
        albumMng.delegate = albumManagerReceiverMock

        //make api call
        albumMng.performRequest(with: "PLAPLA")

        waitForExpectations(timeout: 1.0)
    }
    
}
