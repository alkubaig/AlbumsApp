//
//  TestingImgs.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 5/3/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

/****************************************
 ** singleton to
 ** 1. retreive imges from bundle and
 ** 2. write imges to local paths
 ** 3. provide links to local paths
****************************************/

class TestingImgs{
    
    //singelton instance
    static let testingImgs = TestingImgs()
    static let testingImgsCount = 3
    
    let testingImgs: [UIImage]
    let imgsLocalURLs: [String]
    
    private init(){
        
        let images = TestingImgs.getImgesFromBundle()
        self.testingImgs = images
        
        let localPathsToImgs = TestingImgs.getLocalPathsToImgs()
        //convert URLs to Strings
        imgsLocalURLs = localPathsToImgs.map({$0.absoluteURL.absoluteString})

        TestingImgs.writeImgsToLocalPaths(images: images, localImgsURLs: localPathsToImgs)
    }

    //MARK:- retreive imges from bundle

    private static func getImgesFromBundle()-> [UIImage]{
    
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
        return images
    }
    
    //MARK:- generate local paths to imges
    
    private static func getLocalPathsToImgs()->[URL]{
        
        var localImgsURLs = [URL]()
               //link to local working directory
               let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        for i in 0..<TestingImgs.testingImgsCount{
                       
            //get img file name
            let imgName = TestFileNames.imgAlbumFileName(i)
                
            //generate a local path to img
             guard let fileURL = documentsUrl?.appendingPathComponent(imgName) else {
                fatalError("link invalid")
            }
 
            localImgsURLs.append(fileURL)
        }
        
        return localImgsURLs
    }
    
    //MARK:- write imges into local paths

    private static func writeImgsToLocalPaths(images: [UIImage], localImgsURLs: [URL] ){
        
        for i in 0..<TestingImgs.testingImgsCount{
                   
            // convert img to data
            guard let imageData = images[i].pngData() else {
                fatalError("img not generated")
            }
            //write img to local fil path
            do {
                try imageData.write(to: localImgsURLs[i], options: .atomic)
            }catch{
                fatalError()
            }
        }
        
    }
}
