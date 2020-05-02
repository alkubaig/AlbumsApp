//
//  TableDataSourceTests.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 4/28/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import XCTest


/****************************************
 *** TableViewDataSorce testing
 **
 ** We use a generic function testDataSource to test TableViewDataSorce
 ** it takes an array of models of any type and three closures
 ** - configCell closure to configure cells
 ** - testDatasource closure to test datasource
 ** - testDelegate closure to test delegate (in our current examples, there is nothing to test)
****************************************/

//MARK:- examples for testing
class TableDataSourceTests: XCTestCase {
        
    //1. test with an array of 3 AlbumCellViewModel albums and AlbumCellViewModel
    func testWith3AlbumsAndAlbumCell(){
        
        //get testing albums
        let albums = TestingFiles.getTestingAlbums()
        let albumsListViewModel = albums.map({ AlbumCellViewModel(album: $0)})
        
        let configFunc =
        {
            (cell: AlbumTableViewCell, vm: AlbumCellViewModel) in cell.albumViewModel = vm
        }

        testDataSource(albumsListViewModel, configFunc)
        { (cell: AlbumTableViewCell, vm: AlbumCellViewModel) in
            XCTAssertEqual(cell.albumName.text, vm.albumName)
            XCTAssertEqual(cell.artistName.text, vm.artistName)
            //testing imges in a seperate class
        }
    }
    
     //2. test with an empty array of models
     func testWithEmptyArray(){
    
        testDataSource([], {_, _ in })
        { (cell,_) in
            XCTFail("should not have any cells")
        }
     }
    
    //3. test with an array of strings and UITableViewCell
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

//MARK:- a generic function to test TableViewDataSorce

extension TableDataSourceTests {
    
    func testDataSource<CellType: UITableViewCell,MVType>(
        _ models: [MVType],
        _ configCell: @escaping(CellType, MVType)->(),
        _ testDatasource: @escaping(CellType, MVType)->()){
        
        //-------------- test set up ---------------//
        
        //setup table
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        tableView.register(CellType.self, forCellReuseIdentifier: Constants.cellId)

       //create custom (dataSource and delegate) object
       let dataSourceDelegate:TableViewDatasourceDelegate<CellType, MVType> = TableViewDatasourceDelegate(cellId:Constants.cellId, configCell: configCell)
            
        //mock table delegate
        let delegateMock = TableViewDelgateMock()
      
       //set the table delegate to be the mock delegate
        dataSourceDelegate.tableViewDelegateProtocol = delegateMock
        
        //set table delegate and datasource to custom (dataSource and delegate) object
        tableView.dataSource = dataSourceDelegate
        tableView.delegate = dataSourceDelegate

        //update models for datasource
        dataSourceDelegate.updateModel(newModel: models)
        tableView.reloadData()
                
        //-------------- test ---------------//
        
       // 1. test sections and number of rows
       XCTAssertEqual(tableView.numberOfSections, 1)
       XCTAssertEqual(tableView.numberOfRows(inSection: 0), models.count)
                
      //test cell (2. delegate) and (3. datasource)
       for i in 0..<models.count{
           let indexPath = IndexPath(row: i, section: 0)
           if let cell = tableView.cellForRow(at: indexPath) as? CellType{
            
                //2.test delegate by selecting a cell
                dataSourceDelegate.tableView(tableView, didSelectRowAt: indexPath)
                XCTAssertEqual(delegateMock.selected, true)
                delegateMock.selected = false
            
                //3. testdatasource
                testDatasource(cell, models[i])
            
           }else{
               XCTFail("cell \(i) is not generated ")
           }
       }
        
   }
}
