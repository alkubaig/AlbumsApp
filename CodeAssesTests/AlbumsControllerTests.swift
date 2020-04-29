//
//  AlbumsControllerTests.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 4/27/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest

class AlbumsControllerTests: XCTestCase {

    var tvc : AlbumTableViewController?
    var albumsListViewModel = [AlbumCellViewModel]()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //1
         let albumManagerMock = AlbumManagerMock()
         //2
        let albums = TestingFiles.getMatchingAlbums()
        albumsListViewModel = albums.map({ AlbumCellViewModel(album: $0)})
         //3 use genetic class for table dataSorce
        let dataSource : TableViewDataSorce<AlbumTableViewCell, AlbumCellViewModel> = TableViewDataSorce(cellId:Constants.cellId, models: albumsListViewModel, configCell: {cell, vm in
             //dependency injuction - property
                cell.albumViewModel = vm
            })

         // dependency (3) injuction - intilizer
         tvc = AlbumTableViewController(albumManager: albumManagerMock,
                                            albumsListViewModel:  albumsListViewModel,
                                            dataSource: dataSource)
    }

    func testExample() {
        
        if let tvc = self.tvc {
            
            let count = tvc.tableView.numberOfRows(inSection: 0)

            XCTAssertEqual(count, 3, "data did not load")
            
            for i in 0..<count{
            
//                let albumsExpectation = expectation(description: "AlbumAPI trying to retrieve new albums")

               let indexPath = IndexPath(row: i, section: 0)
               if let cell = tvc.tableView.cellForRow(at: indexPath) as? AlbumTableViewCell{
                   
                    XCTAssertEqual(cell.albumName.text, albumsListViewModel[i].albumName)
                    XCTAssertEqual(cell.artistName.text, albumsListViewModel[i].artistName)

//                albumsExpectation.fulfill()
//                waitForExpectations(timeout: 1.0)

               }
            }
        }
    
        tvc?.tableView.scrollsToTop
    
    }

}
