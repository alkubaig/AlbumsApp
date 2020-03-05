//
//  AlbumViewExample.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit
class AlbumViewController: UITableViewController {
    
//    var safeArea: UILayoutGuide!
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

extension AlbumViewController {
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numAlbums
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AlbumTableViewCell {
            if indexPath.row <  albums.count{
                cell.album = albums[indexPath.row]
            }
            return cell
        }
        
        return AlbumTableViewCell()
        
       
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let destCv = DetailsViewController()
        destCv.album = albums[indexPath.row]
        navigationController?.pushViewController(destCv, animated: true)

    }

}

// MARK: AlbumViewExample

extension AlbumViewController: AlbumManagerDelegate {
    
    func didLoadAlbum(_ albumManager: AlbumManager, album: [Album]) {
        DispatchQueue.main.async {
            self.albums = album

            for i in 0 ..< album.count {
                let indexPath = IndexPath(row: i, section: 0)
                if let cell = self.tableView.cellForRow(at: indexPath) as? AlbumTableViewCell{
                    cell.album = album[i]
                }
            }
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
