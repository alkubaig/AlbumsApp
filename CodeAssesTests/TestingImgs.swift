//
//  TestingImgs.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 5/3/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

//singleton to retreive imges from bundle

class TestingImgs{
    
    static let testingImgs = TestingImgs()
    static let testingImgsCount = 3

    let getTestingImgs: [UIImage]

    private init(){
     
        var images = [UIImage]()

        for i in 0..<TestingImgs.testingImgsCount{
             //get img file name
             let imgName = TestFileNames.imgAlbumFileName(i)

             //get img from project
             guard let img = UIImage(named: imgName) else {

                 fatalError("no image \(imgName)")
             }
             images.append(img)
         }
        self.getTestingImgs = images
    }

}
