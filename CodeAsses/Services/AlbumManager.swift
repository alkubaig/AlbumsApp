//
//  AlbumManeger.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation

protocol AlbumManagerDelegate {
    func didLoadAlbum(albums: [Album])
    func didFailWithError(error: Error)
}

struct AlbumManager {

    var delegate: AlbumManagerDelegate?
    
    func fetchAlbum(numAlbums: Int) {
        let urlString = "\(Constants.albumURL)&q=\(String(numAlbums))/explicit.json"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                if let safeData = data {
                    if let album = self.parseJSON(safeData) {
                        self.delegate?.didLoadAlbum(albums: album)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ albumData: Data) -> [Album]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(AlbumsData.self, from: albumData)
            return decodedData.albumsData
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
