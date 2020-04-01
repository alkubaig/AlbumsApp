//
//  AlbumManeger.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation

protocol AlbumManagerDelegate {
    func didLoadAlbum(_ albumManager: AlbumManager, albums: [Album])
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
                        self.delegate?.didLoadAlbum(self, albums: album)
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
            let res = decodedData.feed.results
            var albums: [Album] = []
            for i in 0 ..< res.count {
                let artistName = res[i].artistName
                let albumName = res[i].name
                let imgUrl = res[i].artworkUrl100
                let url = res[i].url
                var genre: [String] = []
                let copyright = res[i].copyright
                let releaseDate = res[i].releaseDate

                for j in 0 ..< res[i].genres.count{
                    genre.append(res[i].genres[j].name)
                }
              
                let album = Album(artistName: artistName, albumName: albumName, imgUrl: imgUrl, releaseDate: releaseDate, copyright: copyright, genre: genre, url: url)
                albums.append(album)
            }
            
            return albums
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
