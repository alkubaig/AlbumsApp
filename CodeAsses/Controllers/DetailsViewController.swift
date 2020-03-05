//
//  DetailsViewController.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/3/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit
class DetailsViewController: UIViewController {

    var album : Album? {
        didSet {
            if let p = album?.imgUrl,
                let url = URL(string: p),
                let data = try? Data(contentsOf: url){
                    albumImg.image = UIImage(data: data)
            }else{
                print("Img do not exist")
            }

            artistName.text = album?.artistName
            albumName.text = album?.albumName
            copyright.text = album?.copyright
            releaseDate.text = album?.releaseDate
            genre.text = album?.genre.joined(separator:"\n")

        }
    }
    
    private var backView: UIView = {
       
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
     private var albumImg: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    private var artistName: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.textColor = .darkGray
        return l
    }()
    
    private var albumName: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 28)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        return l
    }()
    
    private var releaseDate: UILabel = {
          let l = UILabel()
          l.font = UIFont.systemFont(ofSize: 14)
          l.textAlignment = .center
          l.numberOfLines = 1
          l.textColor = .gray
          return l
      }()
    
    private var copyright: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.textColor = .gray
        return l
    }()
    
    private var genre: UILabel = {
          let l = UILabel()
          l.font = UIFont.italicSystemFont(ofSize: 16)
        
          l.textAlignment = .center
          l.numberOfLines = 0
          l.lineBreakMode = .byWordWrapping
          l.textColor = .darkGray
          return l
      }()
    
    
    private var button : UIButton = {
          let bt = UIButton()
        bt.backgroundColor = .darkGray
        bt.setTitle("View Album!", for: UIControl.State.normal)
        bt.layer.cornerRadius = bt.frame.size.width / 2;
        bt.clipsToBounds = true;
        bt.addTarget(self, action: #selector(viewAlbum), for: UIControl.Event.touchUpInside)
        
          return bt
      }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(backView)
        backView.addSubview(albumImg)
        backView.addSubview(albumName)
        backView.addSubview(artistName)
        backView.addSubview(button)

        backView.addSubview(copyright)
        backView.addSubview(releaseDate)
        backView.addSubview(genre)

        let viewSize = self.view.frame.size
                
        backView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: viewSize.width, height: viewSize.height, enableInsets: true)
        
        albumImg.anchor(top: backView.topAnchor, left: backView.leftAnchor, bottom: nil, right: backView.rightAnchor, paddingTop: 90, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: viewSize.width , height: viewSize.width , enableInsets: true)
        
        albumName.anchor(top: albumImg.bottomAnchor, left: backView.leftAnchor, bottom: nil, right: backView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0 , enableInsets: true)
        
        releaseDate.anchor(top: albumName.bottomAnchor, left: backView.leftAnchor, bottom: nil, right: backView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0 , enableInsets: true)
        
        artistName.anchor(top: releaseDate.bottomAnchor, left: backView.leftAnchor, bottom: nil, right: backView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0 , enableInsets: true)

        genre.anchor(top: artistName.bottomAnchor, left: backView.leftAnchor, bottom: nil, right: backView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0 , enableInsets: true)
        
        button.anchor(top: nil, left: backView.leftAnchor, bottom: backView.bottomAnchor, right: backView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0 , enableInsets: true)

        copyright.anchor(top: nil, left: backView.leftAnchor, bottom: button.topAnchor, right: backView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 20, paddingRight: 10, width: 0, height: 0 , enableInsets: true)

               
    }
    
    @objc func viewAlbum(sender: UIButton!) {
        
         if let url = album?.url, let valid_url = URL(string: url),
            UIApplication.shared.canOpenURL(valid_url) {
                UIApplication.shared.open(valid_url)
         }else{
            print("Error")
        }
            
    }
    

}
