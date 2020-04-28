//
//  TestFiles.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 4/24/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation

struct TestingFiles{
    
    func getContentFromFile(_ name: String, _ type: String?, complition: (_ data: Data)->Void){

        if let path = Bundle.main.path(forResource: name, ofType: type) {
            let url = URL(fileURLWithPath: path)
            do {
                
                let data = try Data(contentsOf: url)
                complition(data)

            }catch{
                fatalError("no data")
            }
            
        }else{
            fatalError("File dose not exist")
        }
    }
    
}

extension TestingFiles {
    // get example albums from plist
    func getMatchingAlbum()->[Album]{
            
        var albums = [Album]()

        TestingFiles().getContentFromFile("Albums","plist"){data in
        
            do {
               let decoder = PropertyListDecoder()
               albums = try decoder.decode([Album].self, from: data)
               
           }catch{
               fatalError("decoder fail")
           }
        }
        return albums
    }
}
