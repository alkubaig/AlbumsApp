//
//  AlbumManegerViewModelTests.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 5/4/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest

/****************************************
 ** AlbumManager testing
 ** Test if performRequest performs the correct response
 ** Make a mock object of AlbumManegerViewModel
****************************************/

class AlbumManegerViewModelTests: XCTestCase {

    // test with a valid response
    func testPerformRequestValid(){
                
        //if FailWithError was called, it is an error
        let expectedBehaviorFordidFailWithError : ((Error) -> Void) = { _ in
            XCTFail("This api should not fail")
        }
        //mock object with a testing closure for each delegate method
        let albumManagerReceiverMock =
            AlbumManagerReceiverMock({ _ in },
                                     expectedBehaviorFordidFailWithError)
                
        //get valid api response from json file with valid albums
        // pass it to performRequest_
        TestingFiles.getContentFromFile(TestFileNames.apiAlbumsFileName, nil) { (data) in
            albumManagerReceiverMock.albumMng.performRequest_(data: data, error: nil)
        }
    }
    
    func testPerformRequestValidEmpty(){
                
        //if FailWithError was called, it is an error
        let expectedBehaviorFordidFailWithError : ((Error) -> Void) = { _ in
            XCTFail("This api should not fail")
        }
        //mock object with a testing closure for each delegate method
        let albumManagerReceiverMock =
            AlbumManagerReceiverMock({ _ in },
                                     expectedBehaviorFordidFailWithError)

        //get valid api response from json file with no albums
        // pass it to performRequest_
        TestingFiles.getContentFromFile(TestFileNames.apiNoAlbumsFileName, nil) { (data) in
            albumManagerReceiverMock.albumMng.performRequest_(data: data, error: nil)
        }
    }
    
    // test with an invalid response
    func testPerformRequestInvalid(){

       //if DidLoadAlbum was called, it is an error
       let expectedBehaviorForDidLoadAlbum : (([Album]) -> Void) = { _ in
           XCTFail("This api should fail")
        }
       
       //mock object with a testing closure for each delegate method
       let albumManagerReceiverMock =
        AlbumManagerReceiverMock(expectedBehaviorForDidLoadAlbum ,{_ in})

        //get valid api response from json file
        // pass it to performRequest_ with an error
        TestingFiles.getContentFromFile(TestFileNames.apiNoAlbumsFileName, nil)
        { (data) in
            albumManagerReceiverMock.albumMng.performRequest_(data: data, error: NetworkErr.noData)
        }
    }
}

