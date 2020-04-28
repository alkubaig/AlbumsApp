//
//  AlbumsViewContollerTests.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 4/27/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest

class AlbumsViewContollerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testConroller(){
        
        //1
       let albumManagerMock = AlbumManagerMock()
       //2
        var albumsListViewModel = [AlbumCellViewModel]()
        let albums = TestingFiles().getMatchingAlbum()
        for album in albums{
            albumsListViewModel.append(AlbumCellViewModel(album: album))
        }
        // let albumsListViewModel = albums.forEach({return AlbumCellViewModel(album: $0)})
       //3 use genetic class for table dataSorce
       let dataSource : TableViewDataSorce<AlbumTableViewCell, AlbumCellViewModel> = TableViewDataSorce(cellId:Constants.cellId, configCell: {cell, vm in
           //dependency injuction - property
              cell.albumViewModel = vm
          })

       // dependency (3) injuction - intilizer
       let tvc = AlbumTableViewController(albumManager: albumManagerMock,
                                          albumsListViewModel:  albumsListViewModel,
                                          dataSource: dataSource)

        let indexPath = IndexPath(row: 0, section: 0)

        if let cell = tvc.tableView.cellForRow(at: indexPath) as? AlbumTableViewCell{

            XCTAssertEqual(cell.albumName.text, albumsListViewModel[0].artistName)

        }else{
            XCTFail()

        }

        
    }

}
