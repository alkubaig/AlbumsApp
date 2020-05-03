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
        let albums = TestingAlbums.testingAlbums.getTestingAlbums
        //get testing imges
        let imgs = TestingImgs.testingImgs.getTestingImgs
        // generte view models of albums
        let albumsListViewModel = albums.map({ AlbumCellViewModel(album: $0)})

        for i in 0..<albums.count{

            let vm = albumsListViewModel[i]
            //place img in chche
            imgCache.setObject(imgs[i], forKey: NSString(string: vm.imgUrl))
                      
            let cell = AlbumTableViewCell()
            //injuct viewModel
            cell.albumViewModel = vm

            //test cells
            XCTAssertEqual(cell.albumName.text, vm.albumName)
            XCTAssertEqual(cell.artistName.text, vm.artistName)
            
            //test img
            if let imgRetreived = cell.albumImg.image {
                //img retreived should be the same as the img we placed in cache
                XCTAssertEqual(imgs[i].pngData(), imgRetreived.pngData())
            }else{
                XCTFail("should have img")
            }
            
        }
    }
    
    override class func tearDown() {
        imgCache.removeAllObjects()
    }
}
