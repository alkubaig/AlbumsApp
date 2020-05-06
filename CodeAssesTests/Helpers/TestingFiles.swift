//
//  TestFiles.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 4/24/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

/****************************************
 ** static methods for testing with files
 ** constants for testing files' names
****************************************/

//MARK:- constants for testing files' names

struct TestFileNames {
    private init(){}
    static let apiAlbumsFileName = "ApiAlbums.json"
    static let apiNoAlbumsFileName = "ApiNoAlbums.json"
    static let plistAlbumsFileName = "Albums.plist"
    static func imgAlbumFileName (_ i: Int)->String {
        return "album\(i).png"
    }
}

//MARK:- a class of methods to test with files

struct TestingFiles{
    
    private init(){}
}

//MARK:- static method for getting the content of a file

extension TestingFiles{

    static func getContentFromFile(_ name: String, _ type: String?, completion: (_ data: Data)->Void){

        if let path = Bundle.main.path(forResource: name, ofType: type) {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                
                //run completion block
                completion(data)

            }catch{
                fatalError("no data")
            }
        }
        else{
            fatalError("File dose not exist")
        }
    }
}

//MARK:- generic funciton to decode a plist

extension TestingFiles {
    
    static func decodePropertyList<T: Decodable>(type: T.Type, data:Data, completion: (T)->Void){
        
        do {
            //intialize decoder
            let decoder = PropertyListDecoder()
            //decode data with type T
            let res =  try decoder.decode(T.self, from: data)
            //run completion block
            completion(res)
            
        }catch{
          fatalError("decoder fail")
        }
    }
}

