//
//  AlbumTableViewCell.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit
class AlbumTableViewCell: UITableViewCell {

    var albumViewModel: AlbumCellViewModel? {
        didSet {
    
            if let url = albumViewModel?.imgUrl{
                albumImg.loadImgeURL(url:  url)
            }
            artistName.text = albumViewModel?.artistName
            albumName.text = albumViewModel?.albumName
        }
    }
    
    private var albumImg : UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = img.frame.size.width / 2;
        img.clipsToBounds = true;
        return img
    }()
    private var artistName: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: Constants.CellFonts.artistNameFont)
        l.numberOfLines = 0
        l.textColor = .darkGray
        return l
    }()
    
    private var albumName : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: Constants.CellFonts.albumNameFont)
        l.numberOfLines = 0
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(albumImg)
        self.contentView.addSubview(artistName)
        self.contentView.addSubview(albumName)

        viewLayout()
    }

    required init(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    
    func viewLayout(){
                
        let cConstraints = Constants.CellConstraints.self
        
        albumImg.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: cConstraints.topImgPadding, paddingLeft: cConstraints.leftImgPadding, paddingBottom: 0, paddingRight: 0, width: cConstraints.imgWidth, height: cConstraints.imgHeight, enableInsets: false)
        
        albumName.anchor(top: topAnchor, left: albumImg.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: cConstraints.topBottomLabelPadding, paddingLeft: cConstraints.leftRightLabelPadding, paddingBottom: 0, paddingRight: cConstraints.leftRightLabelPadding, enableInsets: false)
        
        artistName.anchor(top: albumName.bottomAnchor, left: albumImg.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: cConstraints.inBetweenLabelPadding, paddingLeft: cConstraints.leftRightLabelPadding, paddingBottom: 0, paddingRight: cConstraints.leftRightLabelPadding, enableInsets: false)
    }
}
