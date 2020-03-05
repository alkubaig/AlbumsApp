//
//  AlbumTableViewCell.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/2/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit
class AlbumTableViewCell: UITableViewCell {

    private var albumImg : UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = img.frame.size.width / 2;
        img.clipsToBounds = true;
        return img
    }()
    private var artistName: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textColor = .darkGray
        l.font = UIFont.systemFont(ofSize: 12)
        return l
    }()
    
    private var albumName : UILabel = {
        let l = UILabel()
        l.lineBreakMode = .byTruncatingMiddle
        return l
    }()
    
    var album: Album? {
        didSet {
            if let p = album?.imgUrl,
                let url = URL(string: p),
                let data = try? Data(contentsOf: url){
                    albumImg.image = UIImage(data: data)
            }else{
                        print("Img do not exist")
            }

            artistName.text = album?.artistName ?? "Loading.."
            albumName.text = album?.albumName ?? "Loading.."
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)


        self.contentView.addSubview(albumImg)
        self.contentView.addSubview(artistName)
        self.contentView.addSubview(albumName)


        albumImg.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        albumName.anchor(top: topAnchor, left: albumImg.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width - 100, height: 20, enableInsets: false)
        artistName.anchor(top: albumName.bottomAnchor, left: albumImg.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width - 100, height: 20, enableInsets: false)
        

    }

    required init(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }

}
