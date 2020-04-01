//
//  DetailsView.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/10/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation
import UIKit

class DetailsView: UIView {

    var albumModel : AlbumViewModel? {
        didSet {
           
            if let safeData = albumModel?.imgData {
                albumImg.image = UIImage(data: safeData)
            }
            
            artistName.text = albumModel?.artistName
            albumName.text = albumModel?.albumName
            copyright.text = albumModel?.copyright
            releaseDate.text = albumModel?.releaseDate
            genre.text = albumModel?.genre
        }
    }
    
    var albumImg: UIImageView = {
        let img = UIImageView()
        return img
    }()

    var artistName: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.textColor = .darkGray
        return l
    }()

    var albumName: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 28)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        return l
    }()

    var releaseDate: UILabel = {
          let l = UILabel()
          l.font = UIFont.systemFont(ofSize: 14)
          l.textAlignment = .center
          l.numberOfLines = 1
          l.textColor = .gray
          return l
      }()

    var copyright: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.textColor = .gray
        return l
    }()

    var genre: UILabel = {
          let l = UILabel()
          l.font = UIFont.italicSystemFont(ofSize: 16)
        
          l.textAlignment = .center
          l.numberOfLines = 0
          l.lineBreakMode = .byWordWrapping
          l.textColor = .darkGray
          return l
      }()


    var showButton : UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .darkGray
        bt.setTitle("View Album!", for: UIControl.State.normal)
        bt.layer.cornerRadius = bt.frame.size.width / 2;
        bt.clipsToBounds = true;
        
          return bt
      }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func initView(){
        
        self.backgroundColor = .white
        
        self.addSubview(albumImg)
        self.addSubview(albumName)
        self.addSubview(artistName)
        self.addSubview(showButton)
        self.addSubview(copyright)
        self.addSubview(releaseDate)
        self.addSubview(genre)
        viewLayout()
    }

    func viewLayout(){
        let viewSize = self.frame.size
        albumImg.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 90, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: viewSize.width , enableInsets: true)

        albumName.anchor(top: albumImg.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0 , enableInsets: true)

        releaseDate.anchor(top: albumName.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0 , enableInsets: true)

        artistName.anchor(top: releaseDate.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0 , enableInsets: true)

        genre.anchor(top: artistName.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0 , enableInsets: true)

        showButton.anchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0 , enableInsets: true)

        copyright.anchor(top: nil, left: self.leftAnchor, bottom: showButton.topAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 20, paddingRight: 10, width: 0, height: 0 , enableInsets: true)
    }
}

