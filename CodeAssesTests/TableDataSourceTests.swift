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
 ** We use a generic functions testDataSource to test dataSource
 ** and testDelegate for testing delegate
****************************************/

//MARK:- examples for testing datasource
class TableDataSourceTests: XCTestCase {
        
    //1. test with an array of 3 AlbumCellViewModel albums and AlbumTableViewCell
    func testDataSourceAlbumCell(){
        
        //get view models
        let albumsListViewModel = TestingAlbums.testingAlbums.albumCellViewModels
    
         //configure cell
        let configFunc = {
            
            (cell: AlbumTableViewCell, vm: AlbumCellViewModel) in
            cell.albumViewModel = vm
        }

        testDataSource(albumsListViewModel, configFunc)
        { //testing closure
            (cell: AlbumTableViewCell, vm: AlbumCellViewModel) in
            XCTAssertEqual(cell.albumName.text, vm.albumName)
            XCTAssertEqual(cell.artistName.text, vm.artistName)
            //testing imges in a seperate class
        }
    }
    
     //2. test with an empty array of models
     func testDataSourceWithEmptyArray(){
    
        testDataSource([], {_, _ in })
        { //testing closure
            (cell,_) in
            XCTFail("should not have any cells")
        }
     }
    
    //3. test with an array of strings and UITableViewCell
    func testDataSourceUICell(){
     
        let count = 5
        let word = "Hello"
        //generate models
        let models = Array(repeating: word, count: count)

         //configure cell
        let configFunc = {
            (cell: UITableViewCell, model:String) in
            
            guard let albel = cell.textLabel else{
                XCTFail("no label")
                return
            }
            albel.text = model
        }
        
        testDataSource(models,configFunc)
        { //testing closure
            (cell, _) in
            guard let text = cell.textLabel?.text else{
                XCTFail("no text")
                return
            }
            XCTAssertEqual(word, text)
        }
    }
}

//MARK:- examples for testing delegate

extension TableDataSourceTests{
    
    //1. test with an array of 3 AlbumCellViewModel albums and AlbumTableViewCell
    func testDelegateWithAlbumCell(){
        //get view models
        let albumsListViewModel = TestingAlbums.testingAlbums.albumCellViewModels
        testDelegate(albumsListViewModel)
    }

    //2. test with an array of strings and UITableViewCell
    func testDelegateWithUICell(){

       let count = 5
       let word = "Hello"
       //generate models
       let models = Array(repeating: word, count: count)
       testDelegate(models)
    }

}

//MARK:- a generic function to test TableViewDataSorce

extension TableDataSourceTests{

/****************************************
 ** testDataSource takes an array of models of any type and two closures
 ** - configCell closure to configure cells
 ** - testDatasource closure to test datasource
****************************************/

    func testDataSource<CellType: UITableViewCell,MVType>(
           _ models: [MVType],
           _ configCell: @escaping(CellType, MVType)->(),
           _ testDatasource: @escaping(CellType, MVType)->()){
           
           //-------------- test set up ---------------//
           
          //create custom (dataSource and delegate) object
          let dataSource = getDataSource(models, configCell)
          let tableView = getTableWithDataSouce(dataSource: dataSource)
                            
           //-------------- test ---------------//
           
         // 1. test sections and number of rows
         XCTAssertEqual(tableView.numberOfSections, 1)
         XCTAssertEqual(tableView.numberOfRows(inSection: 0), models.count)
                   
         //2. test cell datasource
         for i in 0..<models.count{
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? CellType{

                 testDatasource(cell, models[i])

            }else{
                XCTFail("cell \(i) is not generated ")
            }
        }
    }
}

//MARK:- a generic function to test TableViewDelegate

/****************************************
 ** testDataSource takes an array of models of any type
 ** we only care about the count of models for this test
****************************************/

extension TableDataSourceTests {
    
    func testDelegate<MVType>(_ models: [MVType]){
           
           //-------------- test set up ---------------//
           
        //create custom (dataSource and delegate) object
        let dataSource = getDataSource(models, {_, _ in })
        let tableView = getTableWithDataSouce(dataSource: dataSource)
        
        //mock table delegate
        let delegateMock = TableViewDelgateMock()

        //set the table delegate to be the mock delegate
        dataSource.tableViewDelegateProtocol = delegateMock
        tableView.delegate = dataSource
                            
           //-------------- test ---------------//
                              
         //test cell delegate
         for i in 0..<models.count{
            let indexPath = IndexPath(row: i, section: 0)
            
            //test delegate by selecting a cell
            dataSource.tableView(tableView, didSelectRowAt: indexPath)
            //if cell has been selected, .selected should be true
            XCTAssertEqual(delegateMock.selected, true)
            delegateMock.selected = false
        }
    }
}

//MARK:- test setup required for both delegate and datasource

extension TableDataSourceTests {
    
    //set up generic dataSource
    func getDataSource<CellType: UITableViewCell,MVType>(
           _ models: [MVType],
           _ configCell: @escaping(CellType, MVType)->())-> TableViewDatasourceDelegate<CellType, MVType>{
        
        //create custom (dataSource and delegate) object
        let dataSource:TableViewDatasourceDelegate<CellType, MVType> = TableViewDatasourceDelegate(cellId:Constants.cellId, configCell: configCell)
        
        dataSource.updateModel(newModel: models)
    
        return dataSource
    }
    
    //set up a table for testing
    func getTableWithDataSouce<CellType, MVType>(
        dataSource: TableViewDatasourceDelegate<CellType, MVType>)-> UITableView{
        
         //setup table
         let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
         tableView.register(CellType.self, forCellReuseIdentifier: Constants.cellId)
          
         //set table delegate and datasource to custom (dataSource and delegate) object
         tableView.dataSource = dataSource
         tableView.reloadData()

        return tableView
    }
  
}
