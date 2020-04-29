//
//  TestFiles.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 4/24/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation

/****************************************
** static methods for testing with files
****************************************/

struct TestingFiles{

    //make this a singleton of static methods for testing
    private init(){}
    static func getContentFromFile(_ name: String, _ type: String?, complition: (_ data: Data)->Void){

        if let path = Bundle.main.path(forResource: name, ofType: type) {

            let url = URL(fileURLWithPath: path)
            do {
                
                let data = try Data(contentsOf: url)
                complition(data)

            }catch{
                fatalError("no data")
            }
        }
        else{
            fatalError("File dose not exist")
        }
    }
    
}

extension TestingFiles {
    
    // generic funciton to decode the content of a plist
    static func decodePropertyList<T: Decodable>(type: T.Type, data:Data, complition: (T)->Void){
        do {
          let decoder = PropertyListDecoder()
            
            let res =  try decoder.decode(T.self, from: data)
            complition(res)
            
        }catch{
          fatalError("decoder fail")
        }
    }
    
    // get example albums from plist
    static func getMatchingAlbums()->[Album]{
            
        var albums = [Album]()

        getContentFromFile("Albums","plist"){ data in
            decodePropertyList(type: [Album].self, data: data){
                res in albums = res
            }
        }
        return albums
    }
}
