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
        
        // generte view models of albums
        let albumsListViewModel = albums.map({ AlbumDetailsViewModel(album: $0)})
        
        for i in 0..<albums.count{
            
            let dView = DetailsView()
            let vm = albumsListViewModel[i]
            dView.albumViewModel = vm
            
            //test test view
            XCTAssertEqual(dView.albumName.text, vm.albumName)
            XCTAssertEqual(dView.artistName.text, vm.artistName)
            XCTAssertEqual(dView.copyright.text, vm.copyright)
            XCTAssertEqual(dView.releaseDate.text, vm.releaseDate)
            XCTAssertEqual(dView.genre.text, vm.genres)
        }
    }
}
