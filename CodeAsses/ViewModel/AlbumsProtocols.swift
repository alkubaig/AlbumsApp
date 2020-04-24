//
//  AlbumsProtocols.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 4/15/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit


// MARK: - protocol for Album properties.

protocol AlbumDetails {
    
    var releaseDate: String {get}
    var copyright: String {get}
    var url: String {get}
    var genre: String {get}
}

protocol AlbumEssentials {
    
    var album: Album {set get}
    var artistName: String {get}
    var albumName: String {get}
    var imgUrl: String {get}
}

extension AlbumEssentials {
    
    var artistName: String {
        return self.album.artistName
    }
    var imgUrl: String{
        return self.album.imgUrl
    }
    var albumName: String{
        return self.album.albumName
    }
}

// MARK: - protocol for Album container height.

protocol AlbumContainerHeight {
    func actualHeight(width: CGFloat)-> CGFloat
    func minHeight()-> CGFloat
    func height(width: CGFloat)-> CGFloat
}

//generic functions to estimate height

extension AlbumContainerHeight{
    
    func height(width: CGFloat) -> CGFloat {
        
        let minHeight = self.minHeight()
        let height = self.actualHeight(width: width)
        return max(minHeight, height)
    }
    
    func paddingsHeight(top: CGFloat, inBetween: CGFloat, labelsCount: Int)->CGFloat{
        
       let topBottomHeight = 2 * top
       let inBetweenHeight = CGFloat(max(labelsCount-1, 0)) * inBetween
       
       return topBottomHeight + inBetweenHeight
    }
       
   func labelsHeight(approxWidth: CGFloat , labels : [(String,CGFloat)])->CGFloat{
    
    let totalHeight : CGFloat = labels.reduce(0,{$0 + $1.0.estimateTextHeight(fontSize: $1.1, approxWidth: approxWidth)})
    
       return totalHeight
   }
}
