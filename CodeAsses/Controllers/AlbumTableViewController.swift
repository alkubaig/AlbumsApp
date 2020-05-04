//
//  AlbumViewExample.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

class AlbumTableViewController: UITableViewController{
    
    private var dataSourceDelegate: TableViewDatasourceDelegate<AlbumTableViewCell, AlbumCellViewModel>?
    var observation: NSKeyValueObservation?
    @objc private var albumsViewModel = AlbumManegerViewModel() //make this object observable
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        self.title = "Albums"
        //fetch albums
        self.albumsViewModel.fetchAlbum(numAlbums: Constants.numAlbums)
        
        setupObserver()
        tableViewSetup()
        dataSouceSetup()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - set up an observer for albums

extension AlbumTableViewController{
    
    func setupObserver(){
        
        observation = observe(\.albumsViewModel.albums, options: [.new])
        { object, change in
                
            //if the albums got updated
            if let newAlbums = change.newValue{
                //reload data
                let albumsListViewModel = newAlbums.map({return AlbumCellViewModel(album: $0)})
    
                //reload data
                 self.dataSourceDelegate?.updateModel(newModel: albumsListViewModel)
                 self.tableView.reloadData()
                 self.title = "\(albumsListViewModel.count) Albums"

            }
        }
    }
}

// MARK: - table setup

extension AlbumTableViewController {
    
    func tableViewSetup(){
    
        tableView.delaysContentTouches = false
        // register cell
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: Constants.cellId)
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        
    }
}

// MARK: - Table datasource

extension AlbumTableViewController: TableViewDelegateProtocol {
    
    func dataSouceSetup (){
     
        //use genetic class for table dataSorce and delegates
        dataSourceDelegate = TableViewDatasourceDelegate(cellId:Constants.cellId){
          cell, vm in
          //dependency injuction - property
          cell.albumViewModel = vm
         }
        
        //use this protocol for selecting rows deleagte
        dataSourceDelegate?.tableViewDelegateProtocol = self
        
        //set datasource and delegates to
        self.tableView.dataSource = self.dataSourceDelegate
        self.tableView.delegate = self.dataSourceDelegate
    }
}

// MARK: - Table delegate method

extension AlbumTableViewController {
    
    //method confirming to TableViewDelegateProtocol
    func didSelectCell(indexPath: IndexPath) {

//        dependency injuction - intializer
        
        let album = albumsViewModel.albums[indexPath.row]
        let albumModel = AlbumDetailsViewModel(album: album)
        
        let destCv = DetailsViewController(albumModel: albumModel)
        self.navigationController?.pushViewController(destCv, animated: true)
    }
}
