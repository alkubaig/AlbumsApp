//
//  TestingAlbums.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 5/3/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

//singleton to retreive albums from property list

class TestingAlbums{
    
    static let testingAlbumsCount = 3

    static let testingAlbums = TestingAlbums()

    let getTestingAlbums: [Album]

    private init(){
     
        var albums = [Album]()

        TestingFiles.getContentFromFile(TestFileNames.plistAlbumsFileName,nil){ data in
            TestingFiles.decodePropertyList(type: [Album].self, data: data){
                res in albums = res
            }
        }
        self.getTestingAlbums = albums
    }
}
