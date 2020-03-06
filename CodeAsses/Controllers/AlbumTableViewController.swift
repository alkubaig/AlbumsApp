//
//  AlbumViewExample.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit
class AlbumTableViewController: UITableViewController {
    
    let cellId =  "id"
    let numAlbums = 100
    var albumManager = AlbumManager()
    var albums : [Album] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        albumManager.delegate = self
        view.backgroundColor = .white

        setupTableView()
    }

    func setupTableView(){

        albumManager.fetchAlbum(numAlbums: numAlbums);
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: cellId)
    }

}

// MARK: AlbumViewExample

extension AlbumTableViewController {
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count > 0 ? albums.count : 10
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let i = indexPath.row
        if i <  albums.count{
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AlbumTableViewCell {
                cell.album = albums[i]
            return cell
            }
        }
        let dCell = UITableViewCell()
        dCell.textLabel?.text = "Loading.."
        return dCell
        
       
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let i = indexPath.row
        if i <  albums.count{
            let destCv = DetailsViewController()
            destCv.album = albums[i]
            navigationController?.pushViewController(destCv, animated: true)

        }

    }

}

// MARK: AlbumViewExample

extension AlbumTableViewController: AlbumManagerDelegate {
    
    func didLoadAlbum(_ albumManager: AlbumManager, album: [Album]) {
        DispatchQueue.main.async {
            self.albums = album
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
