//
//  AlbumTableViewCell.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

/****************************************
**  a custom class for album cell
****************************************/

class AlbumTableViewCell: UITableViewCell {

    //dependency injuction - property
    var albumViewModel: AlbumCellViewModel? {
        // when the view model is set, UI elements are set
        didSet {
    
            if let url = albumViewModel?.imgUrl{
                
                //getImg by loading if new, otherwise by caching
                albumImg.getImg(url:  url)
            }
            artistName.text = albumViewModel?.artistName
            albumName.text = albumViewModel?.albumName
        }
    }
    
    var albumImg : UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = img.frame.size.width / 2;
        img.clipsToBounds = true;
        return img
    }()
    var artistName: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: Constants.CellFonts.artistNameFont)
        l.numberOfLines = 0
        l.textColor = .darkGray
        return l
    }()
    
    var albumName : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: Constants.CellFonts.albumNameFont)
        l.numberOfLines = 0
        return l
    }()
    
    //Stack View for labels
    var stackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.spacing   = Constants.CellConstraints.inBetweenLabelPadding
        stackView.backgroundColor = .blue
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(albumImg)
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(artistName)
        stackView.addArrangedSubview(albumName)
        
        viewLayout()
    }

    required init(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    
    func viewLayout(){
                
        let cConstraints = Constants.CellConstraints.self
        let marginGuide = contentView.layoutMarginsGuide

        albumImg.anchor(top: topAnchor, paddingTop: cConstraints.topImgPadding, enableInsets: false)
        albumImg.anchor(left: leftAnchor, paddingLeft: cConstraints.leftImgPadding)
        albumImg.anchor(width: cConstraints.imgWidth, height: cConstraints.imgHeight)

//        stackView.anchor(top: marginGuide.topAnchor, bottom: marginGuide.bottomAnchor, paddingTop: cConstraints.topBottomLabelPadding, paddingBottom: cConstraints.topBottomLabelPadding, enableInsets: false)
        
        stackView.anchor(top: marginGuide.topAnchor, paddingTop: cConstraints.topBottomLabelPadding, enableInsets: false)
        
        stackView.anchor(left: albumImg.rightAnchor, right: rightAnchor, paddingLeft: cConstraints.leftRightLabelPadding, paddingRight: cConstraints.leftRightLabelPadding)
        
    }
}
