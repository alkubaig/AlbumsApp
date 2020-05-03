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
 ** (test custom decoder)
****************************************/

extension AlbumManagerTests{
    
    // (1.1) "ApiAlbums.json" simulates an example api json response with 3 albumns
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
    
    // (1.2) "ApiNoAlbums.json" file simulates an example api json response with no albums
    func testParseJSON_ApiEmptyAlbumsArray(){
        
        //get valid api response from json file with no albums
        // pass it to parseJSON
        parseJsonFileWithParseJSON(fileName: TestFileNames.apiNoAlbumsFileName){ result in

            XCTAssertEqual(result.count, 0, "This should be empty")
        }
    }
}

//MARK: - methods for testing set 1

extension AlbumManagerTests{
    
    // get api result from json file and parse it through maneger method parseJSON
      func parseJsonFileWithParseJSON(fileName: String, testFunc: (_ result: [Album])->Void){
          
          TestingFiles.getContentFromFile(fileName,nil){data in
               
            //completion block calls parseJSON
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

extension AlbumManagerTests{
    // (2.1) test with a valid response
    func testPerformRequestValid(){
                
        //if FailWithError was called, it is an error
        let expectedBehaviorFordidFailWithError : ((Error) -> Void) = { _ in
            XCTFail("This api should not fail")
        }
        //mock object with a testing closure for each delegate method
        let albumManagerReceiverMock =
            AlbumManagerReceiverMock({ _ in},
                                     expectedBehaviorFordidFailWithError)
        
        albumMng.delegate = albumManagerReceiverMock
        
        //get valid api response from json file with valid albums
        // pass it to performRequest_
        TestingFiles.getContentFromFile(TestFileNames.apiAlbumsFileName, nil) { (data) in
            albumMng.performRequest_(data: data, error: nil)
        }

        //get valid api response from json file with no albums
        // pass it to performRequest_
        TestingFiles.getContentFromFile(TestFileNames.apiNoAlbumsFileName, nil) { (data) in
            albumMng.performRequest_(data: data, error: nil)
        }
    }
    
    // (2.2) test with an invalid response
    func testPerformRequestInvalid(){

       //if DidLoadAlbum was called, it is an error
       let expectedBehaviorForDidLoadAlbum : (([Album]) -> Void) = { _ in
           XCTFail("This api should fail")
        }
       
       //mock object with a testing closure for each delegate method
       let albumManagerReceiverMock =
        AlbumManagerReceiverMock(expectedBehaviorForDidLoadAlbum ,{_ in})
        albumMng.delegate = albumManagerReceiverMock

        //get valid api response from json file
        // pass it to performRequest_ with an error
        TestingFiles.getContentFromFile(TestFileNames.apiNoAlbumsFileName, nil)
        { (data) in
            albumMng.performRequest_(data: data, error: NetworkErr.noData)
        }
    }
}


//MARK: -  test set 3

/****************************************
 ** test if performRequest performs the correct response
 ** using a mock delegate object
 ** Set 2 is a better way to test this functionality to avoid doing http calls in testing,
 ** but I left it for demonstration
****************************************/

extension AlbumManagerTests{

    // (3.1) test with a valid url
    func testPerformRequestValidUrl(){
        
        //use expectation to wait for api call to finish before testing
        let albumsExpectation = expectation(description: "AlbumAPI trying to retrieve new albums")

        //if no albums, this is an error
        let expectedBehaviorForDidLoadAlbum : (([Album]) -> Void) = { album in
            XCTAssertGreaterThan(album.count,0)
            albumsExpectation.fulfill()
         }
        
        //if idFailWithError is called, this is an error
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
     func testPerformRequestInvalidUrl(){
        
        //use expectation to wait for api call to finish before testing
        let albumsExpectation = expectation(description: "AlbumAPI trying to retrieve new albums")

        //if DidLoadAlbum is called, this is an error
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

