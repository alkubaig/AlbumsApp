//
//  Constants.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/30/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

struct Constants{
        
    private init(){}

    static let cellId =  "id"
    static let numAlbums = 100
    static let albumURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/"
    static let observerKey = "observeAlbumsUpdate"
    // url constructed with num of albums
    static let fullAlbumURL = "\(albumURL)&q=\(String(numAlbums))/explicit.json"
    
    struct CellFonts {
        
        private init(){}

        static let artistNameFont : CGFloat = 16
        static let albumNameFont : CGFloat = 18
    }
    
    struct DetailsFonts {
         
        private init(){}

        static let artistNameFont : CGFloat = 18
        static let albumNameFont : CGFloat = 28
        static let releaseDateFont : CGFloat = 14
        static let copyrighteFont : CGFloat = 12
        static let genreFont : CGFloat = 16
     }
    
    struct CellConstraints {
        
        private init(){}

        static let imgHeight : CGFloat = 70
        static let imgWidth : CGFloat = 70
        
        static let topImgPadding : CGFloat = 5
        static let leftImgPadding : CGFloat = 5
        
        static let topBottomLabelPadding : CGFloat = 15
        static let inBetweenLabelPadding : CGFloat = 15
        static let leftRightLabelPadding : CGFloat = 15
    }
    
    struct DetailsConstraints {
        
        private init(){}
            
        static let topBottomLabelPadding : CGFloat = 10
        static let inBetweenLabelPadding : CGFloat = 20
        static let leftRightLabelPadding : CGFloat = 10
        
        static let topBottomButtonPadding : CGFloat = 20
        static let leftRightButtonPadding : CGFloat = 20
    }
}


