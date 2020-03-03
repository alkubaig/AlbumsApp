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
    let numAlbums = 10
    var albumManager = AlbumManager()
    var albums : [Album] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        albumManager.delegate = self
        view.backgroundColor = .white

        setupTableView()
    }

    func setupTableView(){
        for _ in 0 ..< self.numAlbums {
            albums.append(Album())
        }

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
  
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        
        let i = indexPath.row
        cell.album = albums[i]

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToDetails", sender: nil)
    }

}

// MARK: AlbumViewExample

extension AlbumViewController: AlbumManagerDelegate {
    
    func didLoadAlbum(_ albumManager: AlbumManager, album: [Album]) {
        DispatchQueue.main.async {
            self.albums = album

            for i in 0 ..< self.numAlbums {
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
