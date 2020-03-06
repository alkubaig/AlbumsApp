//
//  AlbumUnitTestCase.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 3/5/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest

//test AlbumManager Model
class AlbumUnitTestCase: XCTestCase {

    let albumMng = AlbumManager()
    var matchingAlbum: [Album] = []
    let testingNums = [0,10,45,50,70,100]

    override func setUp() {
        
        super.setUp()
        setUpAlbums()
    }

    //test if parseJSON parses json object correctly
    func jsonFromFile(fileName: String, testFunc: (_ result: [Album])->Void){
        
        if let path = Bundle.main.path(forResource: fileName , ofType: nil) {
            do{
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path))
                    if let result = albumMng.parseJSON(data){
                        testFunc(result)
                    }else{
                        XCTFail("data can not be parsed!")
                    }
                        
                } catch {
                    XCTFail("Test data does not exist")
                }
            }
        }else{
            XCTFail("File dose not exist")

        }
    }
    
    //test the function parseJSON with a json object from file with 3 albums
    func unitTest1(result: [Album]){
        
        XCTAssertEqual(result.count, 3, "Missing some Albums!")
    
        for i in 0..<result.count{
           compareAlbums(a: result[i], b: matchingAlbum[i])
       }
    }
    
    //test the function parseJSON with a json object from file with no albums
    func unitTest2(result: [Album]){
        
        XCTAssertEqual(result.count, 0, "This should be empty")

    }
    //test fetchAlbum with different numbers
    func unitTest3(){
          for num in testingNums{
                 albumMng.fetchAlbum(numAlbums: num)

             }
      }
    
    //test performRequest with invalid sting for URL
     func unitTest4(){
         
         albumMng.performRequest(with: "PLAPLA")
       }
    
    func testExample() {
        
        jsonFromFile(fileName: "test.json", testFunc: unitTest1)
        jsonFromFile(fileName: "test2.json", testFunc: unitTest2)
        unitTest3()
        unitTest4()
    }

}

extension AlbumUnitTestCase{
    
    func setUpAlbums(){
           let album1 = Album(artistName: "Lady Gaga", albumName: "Chromatica", imgUrl: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/cb/1d/32/cb1d32f1-9ce1-0fb4-839a-76c3cab243f1/20UMGIM15390.rgb.jpg/200x200bb.png", releaseDate: "2020-04-10", copyright: "℗ 2020 Interscope Records", genre: ["Pop","Music"], url: "https://music.apple.com/us/album/chromatica/1500951604?app=music")
           
           let album2 = Album(artistName: "The Weeknd", albumName: "After Hours", imgUrl: "https://is2-ssl.mzstatic.com/image/thumb/Music124/v4/06/e5/8c/06e58ce4-a813-8d5b-ef64-03a69064773c/20UMGIM12176.rgb.jpg/200x200bb.png", releaseDate: "2020-03-20", copyright: "℗ 2020 The Weeknd XO, Inc., manufactured and marketed by Republic Records, a division of UMG Recordings, Inc.", genre: ["R&B/Soul","Music"], url: "https://music.apple.com/us/album/after-hours/1499378108?app=music")
           let album3 = Album(artistName: "J Balvin", albumName: "Colores", imgUrl: "https://is3-ssl.mzstatic.com/image/thumb/Music114/v4/0f/16/dc/0f16dc27-a647-01ca-ff46-2da95e65c1b8/20UMGIM10542.rgb.jpg/200x200bb.png", releaseDate:  "2020-03-19", copyright: "Universal Music Latino; ℗ 2020 UMG Recordings, Inc.", genre: ["Urbano latino","Music","Latino"], url: "https://music.apple.com/us/album/colores/1500490683?app=music")

           matchingAlbum.append(album1)
           matchingAlbum.append(album2)
           matchingAlbum.append(album3)
       }
       
    
    func compareAlbums(a: Album, b: Album){
        
        XCTAssertEqual(a.artistName, b.artistName, "artistName not encoded correctly!")
        XCTAssertEqual(a.albumName, b.albumName, "albumName not encoded correctly!")
        XCTAssertEqual(a.url, b.url, "url not encoded correctly!")
        XCTAssertEqual(a.imgUrl, b.imgUrl, "imgUrl not encoded correctly!")
        XCTAssertEqual(a.genre, b.genre, "genre not encoded correctly!")
        XCTAssertEqual(a.releaseDate, b.releaseDate, "releaseDate not encoded correctly!")
        XCTAssertEqual(a.copyright, b.copyright, "copyright not encoded correctly!")

    }
    
    
    
}
