//
//  AlbumsControllerTests.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 4/27/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest

//integration test
class AlbumsControllerTests: XCTestCase {

    func testExample() {
        
        let albumLoadExpectation = expectation(description: "Trying to retrieve albums")
        //get testing albums
        let albums = TestingFiles.getTestingAlbums()
        //get testing imges
        let imgs = TestingFiles.getTestImgesFromBundle()
        
        //1
        let albumsListViewModel = [AlbumCellViewModel]()
       //2
        let albumManagerMock = AlbumManagerMock(albums: albums)
        {
            albumLoadExpectation.fulfill()
        }
       //3 use genetic class for table dataSorce
        let dataSourceDelegate : TableViewDatasourceDelegate<AlbumTableViewCell, AlbumCellViewModel> = TableViewDatasourceDelegate(cellId:Constants.cellId)
          {cell, vm in
           //dependency injuction - property
              cell.albumViewModel = vm
          }
        
        //put images in cache
        for i in 0..<albums.count{
            imgCache.setObject(imgs[i], forKey: NSString(string: albums[i].imgUrl))
        }
    
        // dependency injuction (4) - intilizer
        let tvc = AlbumTableViewController(albumManager: albumManagerMock,
                                            albumsListViewModel: albumsListViewModel,
                                            dataSource: dataSourceDelegate)
                
//        let _ = tvc.tableView

        let navigation = UINavigationController(rootViewController: tvc)

        UIApplication.shared.keyWindow?.rootViewController = navigation

        waitForExpectations(timeout: 1.0)
        let count = tvc.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(count, albums.count, "data did not load")
        
        //test cells
        for i in 0..<count{

           let indexPath = IndexPath(row: i, section: 0)
           if let cell = tvc.tableView.cellForRow(at: indexPath) as? AlbumTableViewCell{
               
                let albumViewModel = AlbumCellViewModel(album: albums[i])
            
                XCTAssertEqual(cell.albumName.text, albumViewModel.albumName)
                XCTAssertEqual(cell.artistName.text, albumViewModel.artistName)
            
                //test img
                if let imgRetreived = cell.albumImg.image {
                   //img retreived should be the same as the img we placed in cache
                   XCTAssertEqual(imgs[i].pngData(), imgRetreived.pngData())
                }else{
                   XCTFail("should have img")
                }
                dataSourceDelegate.tableView(tvc.tableView, didSelectRowAt: indexPath)
        
                guard let detailedView = navigation.topViewController as? DetailsViewController else {
                    XCTFail("dv not there!")
                    return
                }
//                XCTAssertEqual(tv.albumModel.albumName, albumViewModel.albumName )

                navigation.popToRootViewController(animated: true)
            
           }
        }
    }
    
    // empty cache
    override class func tearDown() {
        imgCache.removeAllObjects()
    }


}
