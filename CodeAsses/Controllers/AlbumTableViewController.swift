//
//  AlbumViewExample.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

class AlbumTableViewController: UITableViewController {
    
    private var albumManager: AlbumManagerProtocol
    private var albumsListViewModel: [AlbumCellViewModel]
    private var dataSource: TableViewDataSorce<AlbumTableViewCell, AlbumCellViewModel>
//    private var tableDelegate: AlbumTableViewDelegate

    private let updateObserver = Notification.Name(rawValue: Constants.observerKey)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        self.title = "Albums"
                
        albumManegerSetup()
        notificationsSetup()
        tableViewSetup()
        dataSouceSetup()
    }
    
    //dependency injuction - intilizer
    init(albumManager: AlbumManagerProtocol,
         albumsListViewModel: [AlbumCellViewModel],
         dataSource: TableViewDataSorce<AlbumTableViewCell, AlbumCellViewModel>) {
        
        self.albumManager = albumManager
        self.albumsListViewModel = albumsListViewModel
        self.dataSource = dataSource
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) can not be implemented")
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
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        
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
    
    func dataSouceSetup (){
        self.tableView.dataSource = self.dataSource
    }
}

// MARK: - Table delegate methods

extension AlbumTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //dependency injuction - intializer
        let albumModel = AlbumDetailsViewModel(album: self.albumsListViewModel[indexPath.row].album)
        let destCv = DetailsViewController(albumModel: albumModel)
        navigationController?.pushViewController(destCv, animated: true)
    }

}

// MARK: - Delegate methods for updating table after HTTP
// use notofications center to update UI and data after the albums have been uploaded (observer)

extension AlbumTableViewController: AlbumManagerDelegate {
    func didLoadAlbum(albums: [Album], completion: @escaping (()->Void)) {
        DispatchQueue.main.async {
                        
            self.albumsListViewModel = albums.map({return AlbumCellViewModel(album: $0)})
            NotificationCenter.default.post(name: self.updateObserver, object: nil)
            completion()
        }

    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - notofication center setup and notification methods
// observer design pattern

extension AlbumTableViewController {
    
    func notificationsSetup(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateAlbumCount), name: updateObserver, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDataSource), name: updateObserver, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableData), name: updateObserver, object: nil)
    }
    
    @objc func updateAlbumCount(){
        self.title = "\(albumsListViewModel.count) Albums"
    }
    
    @objc func updateDataSource(){
        self.dataSource.updateModel(newModel: self.albumsListViewModel)
    }

    @objc func updateTableData(){
        print("relaoded")
        self.tableView.reloadData()
    }
}
