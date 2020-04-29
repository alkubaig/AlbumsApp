//
//  AlbumsTableCellTests.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 4/28/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest

/****************************************
** AlbumTableViewCell testing
****************************************/

class AlbumsTableCellTests: XCTestCase {

    func testCells(){
        
        //get testing albums
        let albums = TestingFiles.getMatchingAlbums()
        // generte view models of albums
        let albumsListViewModel = albums.map({ AlbumCellViewModel(album: $0)})
        
        for i in 0..<albums.count{
            
            let cell = AlbumTableViewCell()
            let vm = albumsListViewModel[i]
            cell.albumViewModel = vm
            
            //test cells 
            XCTAssertEqual(cell.albumName.text, vm.albumName)
            XCTAssertEqual(cell.artistName.text, vm.artistName)
            
            if let img = UIImage(named: "album\(i).png", in: Bundle(for: type(of: self)), compatibleWith: nil){
                if let cellImg = cell.albumImg.image {
                    
                    print(cellImg)
                }else{
                    fatalError("cellImg\(i)")

                }

            }else{
                fatalError("album\(i).png")

            }

            
//            if let img = UIImage(contentsOfFile: "album\(i).png"){
//                print(img)
//            }else{
//                fatalError("album\(i).png")
//            }
            
        }
    }
}
