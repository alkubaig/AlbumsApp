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
                albumImg.getImg(url:  url)
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
        l.lineBreakMode = .byWordWrapping
        return l
    }()
    
    private var albumName : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: Constants.CellFonts.albumNameFont)
        l.lineBreakMode = .byWordWrapping
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

        albumImg.anchor(top: topAnchor, paddingTop: cConstraints.topImgPadding, enableInsets: false)
        albumImg.anchor(left: leftAnchor, paddingLeft: cConstraints.leftImgPadding)
        albumImg.anchor(width: cConstraints.imgWidth, height: cConstraints.imgHeight)

        
        albumName.anchor(top: topAnchor, paddingTop: cConstraints.topBottomLabelPadding, enableInsets: false)
        albumName.anchor(left: albumImg.rightAnchor, right: rightAnchor, paddingLeft: cConstraints.leftRightLabelPadding, paddingRight: cConstraints.leftRightLabelPadding)

        
        artistName.anchor(top: albumName.bottomAnchor, paddingTop: cConstraints.inBetweenLabelPadding, enableInsets: false)
        artistName.anchor(left: albumImg.rightAnchor, right: rightAnchor, paddingLeft: cConstraints.leftRightLabelPadding, paddingRight: cConstraints.leftRightLabelPadding)

    }
}
