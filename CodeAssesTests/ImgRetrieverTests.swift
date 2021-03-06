//
//  ImgRetrieverTests.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 4/29/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest

/****************************************
** ImgRetreiver testing
****************************************/

class ImgRetrieverTests: XCTestCase {
        
    //empty cache after each test
    override func tearDown() {
        imgCache.removeAllObjects()
    }
}
//MARK:- test img retreival with valid local paths

extension ImgRetrieverTests{
    
    //test img retreival with valid local paths
   func testValidImgRetriever(){
    
        let imgs = TestingImgs.testingImgs.testingImgs
        let localFileURLs = TestingImgs.testingImgs.imgsLocalURLs

        //repeat test for each img
        for i in 0..<imgs.count{

            //-------- set up ------------//
           
           //generate a UIImageView object that retreives images
           let imgFromRetreiver = ImgRetriever()
           
           let imgLoadExpectation = expectation(description: "Trying to retrieve new img")

           //use a mock protocol object that allows us to wait fot http call to finish
           imgFromRetreiver.imgReteriveProtocol = ImgReteriveMock({ imgLoadExpectation.fulfill()})
           
           //retreive img from local fila path
           imgFromRetreiver.getImg(url: localFileURLs[i])
           
           waitForExpectations(timeout: 1.0)
            
            //-------- test ------------//

            //get img -- from bundle
            let img = imgs[i]
            
           guard let imgRetreived = imgFromRetreiver.image else {
               fatalError("no img\(i)")
           }
            
            // img from file should be the same as the one in UIImgView
            XCTAssertEqual(img.pngData(), imgRetreived.pngData())
       }
   }
}

//MARK:- test img retreival with invalid link

extension ImgRetrieverTests {
    
    //test img retreival with an invalid link
    func testInvalidImgRetriever(){
           
       let imgFromRetreiver = ImgRetriever()
    
       //use a mock protocol object that allows us to wait fot http call to finish
        imgFromRetreiver.imgReteriveProtocol = ImgReteriveMock({})
      
      //makeAnInvalidLinkName
      let url = "plapla"
      
      //attempt to retreive img
      imgFromRetreiver.getImg(url: url)
                   
       //this should fail, otherwise it is an error
      guard let _ = imgFromRetreiver.image else {
           return
       
      }
       XCTFail("img retreive should fail")
    }
}

//MARK:- test caching

extension ImgRetrieverTests{
    
    //test that img is in cache after retreiving
    func testValidImgRetrieverCache(){
     
         let imgs = TestingImgs.testingImgs.testingImgs
         let localFileURLs = TestingImgs.testingImgs.imgsLocalURLs

         //repeat test for each img
         for i in 0..<imgs.count{

             //-------- set up ------------//
            
            //generate a UIImageView object that retreives images
            let imgFromRetreiver = ImgRetriever()
            
            let imgLoadExpectation = expectation(description: "Trying to retrieve new img")

            //use a mock protocol object that allows us to wait fot http call to finish
            imgFromRetreiver.imgReteriveProtocol = ImgReteriveMock({ imgLoadExpectation.fulfill()})
            
            //get img link -- from local file path
            let url = localFileURLs[i]
            
            //retreive img from local fila path
            imgFromRetreiver.getImg(url: url)
            
            waitForExpectations(timeout: 1.0)
             
             //-------- test ------------//

             //get img -- from bundle
             let img = imgs[i]
         
             // check that img is stored in cache
             if let chachedImg = imgCache.object(forKey:NSString(string: url)){
                 XCTAssertEqual(chachedImg.pngData(), img.pngData())
             }else{
                 XCTFail("img should be stored in cache")
             }
        }
    }
    
    //test that img is retreived immediately if place in cache in advanced
    func testImgRetrieverCache(){
        
        let imgs = TestingImgs.testingImgs.testingImgs
        //repeat test for each img
        for i in 0..<imgs.count{

            //-------- set up ------------//

            //get img -- from project bundle
            let img = imgs[i]
          
            //get img name (use as link)
            let url = TestFileNames.imgAlbumFileName(i)

            //place img in chche
            imgCache.setObject(img, forKey: NSString(string: url))
          
            //generate a UIImageView object that retreives images
            let imgFromRetreiver = ImgRetriever()
            
            //-------- test ------------//

            //retreive img with no wait time
            imgFromRetreiver.getImg(url: url)
            
            //should be able to retreive img without a wait
            guard let imgRetreived = imgFromRetreiver.image else {
                XCTFail("img should be stored in cache")
                return
            }

           //img retreived should be the same as the img we placed in cache
           XCTAssertEqual(imgs[i].pngData(), imgRetreived.pngData())
      }

    }
}


