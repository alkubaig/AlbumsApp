//
//  AlbumCellViewModelTests.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 5/4/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest

/****************************************
** AlbumCellViewModel testing
****************************************/

//MARK: - test cellViewModel 

class AlbumCellViewModelTests: XCTestCase {
    
    //test that album view model processes albums correctly using testing albums
    func testAlbumCelllViewModel(){
                        
        // get testing albums from "Albums.plist"
        let matchingAlbum = TestingAlbums.testingAlbums.testingAlbums
        if matchingAlbum.count == 0 {fatalError()}
        for i in 0..<matchingAlbum.count{
            
            let album = matchingAlbum[i]
            
            let albumCellViewModel = AlbumCellViewModel(album: album)
            //test if AlbumCellViewModel calcualates the correct values
            testCellViewModel(album: album, albumViewModel: albumCellViewModel)
        }
    }
    
}
//MARK: - methods for comparing with view model

extension AlbumCellViewModelTests{
    
    //compare album with AlbumCellModel
    
    func testCellViewModel(album: Album, albumViewModel: AlbumCellViewModel){
        
        XCTAssertEqual(album.artistName, albumViewModel.artistName, "artistName not set!")
        XCTAssertEqual(album.albumName, albumViewModel.albumName, "albumName not set!")
        XCTAssertEqual(album.imgUrl, albumViewModel.imgUrl, "imgUrl not set!")
    }
}
