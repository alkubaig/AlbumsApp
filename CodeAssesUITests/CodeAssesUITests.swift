//
//  CodeAssesUITests.swift
//  CodeAssesUITests
//
//  Created by Ghadeer Alkubaish on 3/5/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//


import XCTest


class CodeAssesUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        app.launch()
        continueAfterFailure = true
    }

    func testCellElements(){
        
        let tablesQuery = app.tables
        let count = tablesQuery.cells.count
        XCTAssertNotEqual(count, 0)
    
        let cells = tablesQuery.cells
        for _ in 0..<3{
            let randCellNum = Int.random(in: 0 ..< count)
            let cell = cells.element(boundBy: randCellNum)
     
            // cell elements
            let albumImg = cell.images[Constants.CellElementId.albumImgId]
            let albumNameLabel = cell.staticTexts[Constants.CellElementId.albumNameId]
            let artistNameLabel = cell.staticTexts[Constants.CellElementId.artistNameId]
           
            //test that cell elements exist
            XCTAssertTrue(albumImg.exists)
            XCTAssertTrue(albumNameLabel.exists)
            XCTAssertTrue(artistNameLabel.exists)
        }
    }
    
    func testDetailedViewElements(){
        
        let tablesQuery = app.tables
        let count = tablesQuery.cells.count
        XCTAssertNotEqual(count, 0)
    
        let cells = tablesQuery.cells
        for _ in 0..<3{
            let randCellNum = Int.random(in: 0 ..< count)
            let cell = cells.element(boundBy: randCellNum)

            cell.tap()
                      
            //get detailed view elements
            let dView = app.scrollViews.otherElements

            let albumImgD = dView.images[Constants.DetailsElementId.albumImgId]
            let albumNameDLabel = dView.staticTexts[Constants.DetailsElementId.albumNameId]
            let artistNameDLabel = dView.staticTexts[Constants.DetailsElementId.artistNameId]

            let copyrightLabel = dView.staticTexts[Constants.DetailsElementId.copyrightId]
            let genreLabel = dView.staticTexts[Constants.DetailsElementId.genreId]
            let releaseDateLabel = dView.staticTexts[Constants.DetailsElementId.releaseDateId]

            //test that detailed view elements exist
            XCTAssertTrue(albumImgD.exists)
            XCTAssertTrue(albumNameDLabel.exists)
            XCTAssertTrue(artistNameDLabel.exists)
            XCTAssertTrue(copyrightLabel.exists)
            XCTAssertTrue(genreLabel.exists)
            XCTAssertTrue(releaseDateLabel.exists)
            
            //tap back button
            let navigation = app.navigationBars.element(boundBy: 0)
            navigation.buttons.element(boundBy: 0).tap()

        }
    }
    
    func testViewAlbumButton(){
         
         let tablesQuery = app.tables
         let count = tablesQuery.cells.count
         XCTAssertNotEqual(count, 0)
     
         let cells = tablesQuery.cells
         for _ in 0..<3{
            let randCellNum = Int.random(in: 0 ..< count)
            let cell = cells.element(boundBy: randCellNum)
      
            //tap cell
            cell.tap()
                       
            //tap button to view item in itunes
            app.buttons["View Album!"].tap()

            //return to app
            app.activate()

            //tap back button
            let navigation = app.navigationBars.element(boundBy: 0)
            navigation.buttons.element(boundBy: 0).tap()
          
         }
     }
    
    func testCellEqualDetails(){
                
        let tablesQuery = app.tables
        let count = tablesQuery.cells.count
        XCTAssertNotEqual(count, 0)
    
        let cells = tablesQuery.cells
        
        for _ in 0..<3{
            let randCellNum = Int.random(in: 0 ..< count)
            let cell = cells.element(boundBy: randCellNum)
      
            // cell elements
            let albumNameLabel = cell.staticTexts[Constants.CellElementId.albumNameId]
            let artistNameLabel = cell.staticTexts[Constants.CellElementId.artistNameId]

            //get labels' text
            let albumName = albumNameLabel.label
            let artistName =  artistNameLabel.label

            //tap cell
            cell.tap()
            
            //get detailed view elements
            let dView = app.scrollViews.otherElements
            
            let albumNameDLabel = dView.staticTexts[Constants.DetailsElementId.albumNameId]
            let artistNameDLabel = dView.staticTexts[Constants.DetailsElementId.artistNameId]

            //get labels' text
            let albumNameD = albumNameDLabel.label
            let artistNameD = artistNameDLabel.label

            //test that detailed view labels match cells labels
            XCTAssertEqual(albumName, albumNameD)
            XCTAssertEqual(artistName, artistNameD)
            
            //tap back button
            let navigation = app.navigationBars.element(boundBy: 0)
            navigation.buttons.element(boundBy: 0).tap()
        }
   
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
