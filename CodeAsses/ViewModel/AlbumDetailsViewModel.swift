//
//  AlbumDetailsViewModel.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 4/15/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

struct AlbumDetailsViewModel : AlbumEssentials, AlbumDetails{
    
    var album : Album

    var releaseDate: String{
        return self.album.releaseDate
    }
    var copyright: String{
        return self.album.copyright
    }
    var url: String{
        return self.album.url
    }
    var genre: String{
        return self.album.genres.map({$0.name}).joined(separator:"\n")
    }
}
//
//extension AlbumDetailsViewModel: AlbumContainerHeight{
//
//    func height(width: CGFloat)-> CGFloat{
//       
//         let dConstraints = Constants.DetailsConstraints.self
//         let fontConsts = Constants.DetailsFonts.self
//
//         let approxWidth = width - 2 * dConstraints.leftRightLabelPadding
//
//         var labels = [(String,CGFloat)]()
//          labels.append((self.artistName,fontConsts.artistNameFont))
//          labels.append((self.albumName,fontConsts.albumNameFont))
//          labels.append((self.releaseDate,fontConsts.releaseDateFont))
//          labels.append((self.genre,fontConsts.genreFont))
//          labels.append((self.copyright,fontConsts.copyrighteFont))
//
//         let totalPaddingsHeight = paddingsHeight(top: dConstraints.topBottomLabelPadding, inBetween: dConstraints.inBetweenLabelPadding, labelsCount: labels.count)
//
//         let totalTextHeight = labelsHeight(approxWidth: approxWidth, labels: labels)
//
//          let height = width + totalTextHeight + totalPaddingsHeight
//
//         return height
//    }
//}
