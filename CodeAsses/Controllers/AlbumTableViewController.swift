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
    private var albumsListViewModel = [AlbumCellViewModel]()
    private var dataSource: TableViewDataSorce<AlbumTableViewCell, AlbumCellViewModel>?
    private let updateObserver = Notification.Name(rawValue: Constants.observerKey)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        self.title = "Albums"
        
        albumManegerSetup()
        notificationsSetup()
        tableViewSetup()
        dataSouceSetup()
        addRefreshController()

    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


// MARK: - table setup

extension AlbumTableViewController {
    
    func tableViewSetup(){
    
        tableView.delaysContentTouches = false
        // register cell
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: Constants.cellId)
    }
}

// MARK: - albumManager

extension AlbumTableViewController {
    
    func albumManegerSetup(){
      
        albumManager.delegate = self
        //fetch all albums
        albumManager.fetchAlbum(numAlbums: Constants.numAlbums)
    }
}

// MARK: - Table datasource

extension AlbumTableViewController {
    
    //use genetic class for table dataSorce
    func dataSouceSetup (){
        
        self.dataSource = TableViewDataSorce(cellId:Constants.cellId , models: albumsListViewModel, configCell: {cell, vm in
                   cell.albumViewModel = vm
               })
        self.tableView.dataSource = self.dataSource
    }
}


// MARK: - Refresh control setup and methods

extension AlbumTableViewController {

    func addRefreshController(){
        refreshControl = UIRefreshControl()
        tableView.tableHeaderView = UIView(frame: .zero)
        if let refreshControl = refreshControl{
            tableView.addSubview(refreshControl)
        }
        refreshControl?.addTarget(self, action: #selector(refreshdData), for: .valueChanged)
    }
    
    @objc func refreshdData(){
        albumManager.fetchAlbum(numAlbums: Constants.numAlbums)
    }
}

// MARK: - Table delegate methods

extension AlbumTableViewController {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let cConstraints = Constants.CellConstraints.self
        let minHeight = (cConstraints.imgHeight + 2 * cConstraints.topImgPadding)
        let height = albumsListViewModel[indexPath.row].height(width: view.frame.width)
        return max(minHeight, height)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let destCv = DetailsViewController()
        destCv.albumModel = AlbumDetailsViewModel(album: self.albumsListViewModel[indexPath.row].album)
        navigationController?.pushViewController(destCv, animated: true)
    }

}

// MARK: - Delegate methods for updating table after HTTP
// use notofications center to update UI and data after the albums have been uploaded

extension AlbumTableViewController: AlbumManagerDelegate {
    func didLoadAlbum(albums: [Album]) {
        DispatchQueue.main.async {
                        
            self.albumsListViewModel = albums.map({return AlbumCellViewModel(album: $0)})
            NotificationCenter.default.post(name: self.updateObserver, object: nil)
            
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - notofication center setup and notification methods

extension AlbumTableViewController {
    
    func notificationsSetup(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateAlbumCount), name: updateObserver, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDataSource), name: updateObserver, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableData), name: updateObserver, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(endRefresher), name: updateObserver, object: nil)
    }
    
    @objc func updateAlbumCount(){
        self.title = "\(albumsListViewModel.count) Albums"
    }
    
    @objc func updateDataSource(){
        self.dataSource?.updateModel(newModel: self.albumsListViewModel)
    }
    
    @objc func endRefresher(){
        self.refreshControl?.endRefreshing()
    }
        
    @objc func updateTableData(){
        print("relaoded")
        self.tableView.reloadData()
    }
}
