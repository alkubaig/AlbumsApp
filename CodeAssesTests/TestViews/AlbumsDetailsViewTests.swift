//
//  AlbumsDetailsViewTests.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 4/28/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

/****************************************
** AlbumDetailsView testing
****************************************/

import XCTest


class AlbumsDetailsViewTests: XCTestCase {

    func testDetailedView(){
        
        //get testing albums
        let albums = TestingFiles.getTestingAlbums()
        //get testing imges
        let imgs = TestingFiles.getTestImgesFromBundle()
        
        // generte view models of albums
        let albumsListViewModel = albums.map({ AlbumDetailsViewModel(album: $0)})
        
        for i in 0..<albums.count{
            
            let vm = albumsListViewModel[i]
            //put image in cache
            imgCache.setObject(imgs[i], forKey: NSString(string: vm.imgUrl))
            
            let dView = DetailsView()
            dView.albumViewModel = vm
            
            //test test view
            XCTAssertEqual(dView.albumName.text, vm.albumName)
            XCTAssertEqual(dView.artistName.text, vm.artistName)
            XCTAssertEqual(dView.copyright.text, vm.copyright)
            XCTAssertEqual(dView.releaseDate.text, vm.releaseDate)
            XCTAssertEqual(dView.genre.text, vm.genres)
            
            //test img
            if let imgRetreived = dView.albumImg.image {
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
