//
//  AlbumManeger.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation

// MARK: - protocol for api delegate methods

protocol AlbumManagerDelegate {
    //dependency injuction - method
    func didLoadAlbum(albums:[Album])
    func didFailWithError(error: Error)
}

// MARK: - methods and properties reqiuired in AlbumManager (useful for mock objects)

protocol AlbumManagerProtocol{
    
    var delegate: AlbumManagerDelegate? { get set }
    func fetchAlbum(numAlbums: Int)
}

// MARK: - AlbumManager

struct AlbumManager: AlbumManagerProtocol {
    
    var delegate: AlbumManagerDelegate?
        
    //fetch albums by calling api
    func fetchAlbum(numAlbums: Int){
        
        //perfom api call
        performRequest(with: Constants.fullAlbumURL)
    }
    
    //perfom HTTP call with url
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in

                self.performRequest_(data: data, error: error)
            }
            task.resume()
        }
    }
    
    //call delegate method based on response
    func performRequest_(data: Data?, error: Error?) {

        if let error = error {
            //if failed, call delegate method didFailWithError
            self.delegate?.didFailWithError(error: error)
            return
        }
        if let safeData = data {
            //if succeed, call delegate method didLoadAlbum after parsing response
            if let album = self.parseJSON(safeData) {
                self.delegate?.didLoadAlbum(albums: album)
            }
        }
    }
    
    // attempt to decode api response with JSONDecoder(custom)
    func parseJSON(_ albumData: Data) -> [Album]? {
        let decoder = JSONDecoder()
        do {
            //if decoding succeed, return the list of albums
            let decodedData = try decoder.decode(AlbumsData.self, from: albumData)
            return decodedData.albumsData
        } catch {
            //if decoding failed, call delegate method didFailWithError
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
