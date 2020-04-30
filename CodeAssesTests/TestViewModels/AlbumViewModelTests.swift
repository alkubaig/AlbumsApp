//
//  AlbumViewModelTests.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 3/5/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest

/****************************************
** AlbumViewModel testing
****************************************/

//test cellViewModel and detailsViewModel
class AlbumViewModelTests: XCTestCase {
    
    //test that album view model processes albums correctly using testing albums 
    func testAlbumViewModel(){
                        
        // get testing albums from "Albums.plist"
        let matchingAlbum = TestingFiles.getTestingAlbums()
        if matchingAlbum.count == 0 {fatalError()}
        for i in 0..<matchingAlbum.count{
            
            let album = matchingAlbum[i]
            
            let albumDetailsViewModel = AlbumDetailsViewModel(album: album)
            //test if AlbumDetailsViewModel calcualates the correct values
            testDetailsViewModel(album: album, albumViewModel: albumDetailsViewModel)
            
            let albumCellViewModel = AlbumCellViewModel(album: album)
            //test if AlbumCellViewModel calcualates the correct values
            testCellViewModel(album: album, albumViewModel: albumCellViewModel)
        }
    }
}
extension AlbumViewModelTests{
    
    
    func testCellViewModel(album: Album, albumViewModel: AlbumCellViewModel){
        
        XCTAssertEqual(album.artistName, albumViewModel.artistName, "artistName not set!")
        XCTAssertEqual(album.albumName, albumViewModel.albumName, "albumName not set!")
        XCTAssertEqual(album.imgUrl, albumViewModel.imgUrl, "imgUrl not set!")
    
    }
    
    func testDetailsViewModel(album: Album, albumViewModel: AlbumDetailsViewModel){
        
        XCTAssertEqual(album.artistName, albumViewModel.artistName, "artistName not set!")
        XCTAssertEqual(album.albumName, albumViewModel.albumName, "albumName not set!")
        XCTAssertEqual(album.imgUrl, albumViewModel.imgUrl, "imgUrl not set!")
        
        XCTAssertEqual(album.url, albumViewModel.url, "url not set!")
        XCTAssertEqual(album.releaseDate, albumViewModel.releaseDate, "releaseDate not set!")
        XCTAssertEqual(album.copyright, albumViewModel.copyright, "copyright not set!")
        let genres = album.genres.map({$0.name}).joined(separator:"\n")
        (XCTAssertEqual(genres, albumViewModel.genres, "genre not set!"))
    }
    
}
