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

    // calculates getTestingImgs property in private init
    private init(){
     
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
    }

}
