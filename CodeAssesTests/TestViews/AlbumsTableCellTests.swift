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

        }
    }
}
