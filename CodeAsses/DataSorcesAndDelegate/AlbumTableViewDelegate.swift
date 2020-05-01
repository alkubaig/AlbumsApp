//
//  AlbumTableViewDelegate.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 4/29/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//
import UIKit

class AlbumTableViewDelegate: NSObject, UITableViewDelegate {
    
    var albumCellViewModels : [AlbumCellViewModel]
    
    init(albumCellViewModels: [AlbumCellViewModel]) {
        self.albumCellViewModels = albumCellViewModels
    }
    
    // dependency injuction - property
    func updateModel(newModel: [AlbumCellViewModel]){
        self.albumCellViewModels = newModel
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return max(height(mv: albumCellViewModels[indexPath.row], width: tableView.frame.width), 100)
    }
}
extension AlbumTableViewDelegate{
    
    func paddingsHeight(top: CGFloat, inBetween: CGFloat, labelsCount: Int)->CGFloat{
         
        let topBottomHeight = 2 * top
        let inBetweenHeight = CGFloat(max(labelsCount-1, 0)) * inBetween
        
        return topBottomHeight + inBetweenHeight
     }
        
    func labelsHeight(approxWidth: CGFloat , labels : [(String,CGFloat)])->CGFloat{
     
     let totalHeight : CGFloat = labels.reduce(0,{$0 + $1.0.estimateTextHeight(fontSize: $1.1, approxWidth: approxWidth)})
     
        return totalHeight
    }
    
    func height(mv: AlbumCellViewModel, width: CGFloat)-> CGFloat{
       
       let cConstraints = Constants.CellConstraints.self
       let fontConsts = Constants.CellFonts.self

       let approxWidth = width - cConstraints.imgWidth - cConstraints.leftImgPadding - 2 * cConstraints.leftRightLabelPadding
       
       var labels = [(String,CGFloat)]()
        
       labels.append((mv.artistName,fontConsts.artistNameFont))
       labels.append((mv.albumName,fontConsts.albumNameFont))
       
       let totalPaddingsHeight = paddingsHeight(top: cConstraints.topBottomLabelPadding, inBetween: cConstraints.inBetweenLabelPadding, labelsCount: labels.count)
       
       let totalTextHeight = labelsHeight(approxWidth: approxWidth, labels: labels)
       let height = totalTextHeight + totalPaddingsHeight
            
       return height
    }
}
