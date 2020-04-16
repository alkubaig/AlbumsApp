//
//  AlbumViewModel.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/12/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

struct AlbumCellViewModel: AlbumEssentials {
    
    var album : Album
}

extension AlbumCellViewModel: AlbumContainerHeight{

    func height(width: CGFloat)-> CGFloat{
       
       let cConstraints = Constants.CellConstraints.self
       let fontConsts = Constants.CellFonts.self

       let approxWidth = width - cConstraints.imgWidth - cConstraints.leftImgPadding - 2 * cConstraints.leftRightLabelPadding
       
       var labels = [(String,CGFloat)]()
       labels.append((self.artistName,fontConsts.artistNameFont))
       labels.append((self.albumName,fontConsts.albumNameFont))
       
       let totalPaddingsHeight = paddingsHeight(top: cConstraints.topBottomLabelPadding, inBetween: cConstraints.inBetweenLabelPadding, labelsCount: labels.count)
       
       let totalTextHeight = labelsHeight(approxWidth: approxWidth, labels: labels)
       let height = totalTextHeight + totalPaddingsHeight
            
       return height
    }
}
