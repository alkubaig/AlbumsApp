//
//  TestingAlbums.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 5/3/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

/****************************************
 ** singleton to retreive albums from our testing property list
****************************************/

class TestingAlbums{

    //singelton instance
    static let testingAlbums = TestingAlbums()

    static let testingAlbumsCount = 3
    let getTestingAlbums: [Album]

    // calculates getTestingAlbums property in private init
    private init(){
     
        var albums = [Album]()
        
        // get content of plist
        TestingFiles.getContentFromFile(TestFileNames.plistAlbumsFileName,nil){ data in
            
            // decode plist with type [Album]
            TestingFiles.decodePropertyList(type: [Album].self, data: data){
               
                res in albums = res
            }
        }

        self.getTestingAlbums = albums
    }
}
