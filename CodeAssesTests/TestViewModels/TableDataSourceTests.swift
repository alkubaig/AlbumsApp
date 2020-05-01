//
//  TableDataSourceTests.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 4/28/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest

/****************************************
** TableViewDataSorce testing
****************************************/

class TableDataSourceTests: XCTestCase {
        
    //test with an array of 3 AlbumCellViewModel albums and AlbumCellViewModel
    func testWith3AlbumsAndAlbumCell(){
        
        //get testing albums
        let albums = TestingFiles.getTestingAlbums()
        let albumsListViewModel = albums.map({ AlbumCellViewModel(album: $0)})
        let configFunc = {(cell: AlbumTableViewCell, vm: AlbumCellViewModel) in cell.albumViewModel = vm}

        testDataSource(albumsListViewModel, configFunc )
        { (cell: AlbumTableViewCell, vm: AlbumCellViewModel) in
            XCTAssertEqual(cell.albumName.text, vm.albumName)
            XCTAssertEqual(cell.artistName.text, vm.artistName)
            //testing imges in a seperate class
        }
    }
    
     //test with an empty array of models
     func testWithEmptyArray(){
        
        testDataSource([], {_, _ in })
        { (cell,_) in
            XCTFail("should not have any cells")
        }
     }
    
    //test with an array of strings and UITableViewCell
    func testWith3StringsAndUICell(){
     
        let count = 5
        let word = "Hello"
        let models = Array(repeating: word, count: count)
                    
        testDataSource(models, {cell, model in cell.textLabel?.text = model})
        {(cell,_) in
            XCTAssertEqual(word, cell.textLabel?.text)
        }
    }
}

/****************************************
** a generic function to test TableViewDataSorce 
** it takes a model of any type and two closures
** one closure to configure cells and one closure to test cells
****************************************/

extension TableDataSourceTests {
    
    func testDataSource<CellType: UITableViewCell,MVType>(_ models: [MVType], _ configCell: @escaping(CellType, MVType)->(), _ testCell: ((CellType, MVType) -> Void)){
           
       //create dataSource
       let dataSource : TableViewDataSorce<CellType, MVType> = TableViewDataSorce(cellId:Constants.cellId, configCell: configCell)
              
       //setup table
       let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        dataSource.updateModel(newModel: models)
       tableView.dataSource = dataSource
       tableView.register(CellType.self, forCellReuseIdentifier: Constants.cellId)
       tableView.reloadData()
                
       // test sections and number of rows
       XCTAssertEqual(tableView.numberOfSections, 1)
       XCTAssertEqual(tableView.numberOfRows(inSection: 0), models.count)
       tableView.reloadData()
                
      //test cells
       for i in 0..<models.count{
           let indexPath = IndexPath(row: i, section: 0)
           if let cell = tableView.cellForRow(at: indexPath) as? CellType{
               testCell(cell, models[i])
           }else{
               XCTFail("cell \(i) is not generated ")
           }
       }
   }
}
