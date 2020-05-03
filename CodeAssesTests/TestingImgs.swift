//
//  TestingImgs.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 5/3/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

/****************************************
 ** singleton to retreive imges from bundle
****************************************/

class TestingImgs{
    
    //singelton instance
    static let testingImgs = TestingImgs()
    static let testingImgsCount = 3
    
    let getTestingImgs: [UIImage]
    let getLocalFileURLs : [String]


    // calculates getTestingImgs property in private init
    private init(){
     
        //MARK:- retreive imges from bundle
        var images = [UIImage]()
        
        for i in 0..<TestingImgs.testingImgsCount{
             
            //get img file name
             let imgName = TestFileNames.imgAlbumFileName(i)

             //get img from bundle
             guard let img = UIImage(named: imgName) else {

                 fatalError("no image \(imgName)")
             }
             images.append(img)
         }
        self.getTestingImgs = images
        
        //MARK:- generate local paths to imges
     
        var localFileURLs = [String]()
        //link to local working directory
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                
        for i in 0..<TestingImgs.testingImgsCount{
                      
           //get img file name
           let imgName = TestFileNames.imgAlbumFileName(i)
               
           //generate a local path to img
            guard let fileURL = documentsUrl?.appendingPathComponent(imgName) else {
               fatalError("link invalid")
           }
           // convert img to data
           guard let imageData = images[i].pngData() else {
               fatalError("img not generated")
           }
           //write img to local fil path
           do {
               try imageData.write(to: fileURL, options: .atomic)
           }catch{
               fatalError()
           }
           localFileURLs.append(fileURL.absoluteURL.absoluteString)
       }
        getLocalFileURLs = localFileURLs
    }

}
