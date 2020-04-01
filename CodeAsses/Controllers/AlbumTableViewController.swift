//
//  AlbumViewExample.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit
class AlbumTableViewController: UITableViewController {
    
    private var albumManager = AlbumManager()
    private var albumsListViewModel = [AlbumViewModel]()
    private var dataSource: TableViewDataSorce<AlbumTableViewCell, AlbumViewModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumManager.delegate = self
        view.backgroundColor = .white
        setupTableView()
    }

    func setupTableView(){
        
        //use genetic class for table dataSorce
        self.dataSource = TableViewDataSorce(cellId:Constants.cellId , models: albumsListViewModel, configCell: {cell, vm in
            cell.albumViewModel = vm
        })
        self.tableView.dataSource = self.dataSource
        
        //fetch all albums
        albumManager.fetchAlbum(numAlbums: Constants.numAlbums)
        
        // register cell
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: Constants.cellId)
    }
}

// MARK: Table functions

extension AlbumTableViewController {
    //
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let destCv = DetailsViewController()
        destCv.albumModel = albumsListViewModel[indexPath.row]
        navigationController?.pushViewController(destCv, animated: true)
    }

}

// MARK: Delegate functions for updating table after HTTP 

extension AlbumTableViewController: AlbumManagerDelegate {
    func didLoadAlbum(_ albumManager: AlbumManager, albums: [Album]) {
        DispatchQueue.main.async {
            
            self.albumsListViewModel = albums.map({return AlbumViewModel(album: $0)})
            self.dataSource?.updateModel(newModel: self.albumsListViewModel)
            self.tableView.reloadData()
            
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
