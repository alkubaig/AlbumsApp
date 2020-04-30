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
****************************************/

struct TestFileNames {
    private init(){}
    static let apiAlbumsFileName = "ApiAlbums.json"
    static let apiNoAlbumsFileName = "ApiNoAlbums.json"
    static let plistAlbumsFileName = "Albums.plist"
    static func imgAlbumFileName (_ i: Int)->String {
        return "album\(i).png"
    }
    static let testingAlbumsCount = 3
    static let testingImgsCount = 3


}

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
    static func decodePropertyList<T: Decodable>(type: T.Type, data:Data, completion: (T)->Void){
        do {
          let decoder = PropertyListDecoder()
            
            let res =  try decoder.decode(T.self, from: data)
            completion(res)
            
        }catch{
          fatalError("decoder fail")
        }
    }
    
    // get example albums from plist
    static func getTestingAlbums()->[Album]{
            
        var albums = [Album]()

        getContentFromFile(TestFileNames.plistAlbumsFileName,nil){ data in
            decodePropertyList(type: [Album].self, data: data){
                res in albums = res
            }
        }
        return albums
    }
}

extension TestingFiles{
    
    static func getTestImgesFromBundle()->[UIImage]{
        
        var images = [UIImage]()

         for i in 0..<TestFileNames.testingImgsCount{
             //get img file name
             let imgName = TestFileNames.imgAlbumFileName(i)

             //get img from project
             guard let img = UIImage(named: imgName) else {

                 fatalError("no image \(imgName)")
             }
             images.append(img)
         }
        return images

     }
    
    
}
