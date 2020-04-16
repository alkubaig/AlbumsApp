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

    var albumModel : AlbumDetailsViewModel?{
        didSet {
           
            if let url = albumModel?.imgUrl{
                //get the image from the cache
                albumImg.loadImgeURL(url: url)
            }
            artistName.text = albumModel?.artistName
            albumName.text = albumModel?.albumName
            copyright.text = albumModel?.copyright
            releaseDate.text = albumModel?.releaseDate
            genre.text = albumModel?.genre
            //set up layout after the albumModel is set to get correct frame
            viewLayout()
        }
    }
    
    private let dConstraints = Constants.DetailsConstraints.self
    
    //scroll view for big text
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    //content view
    private var view: UIView = {
         let view = UIView()
         return view
     }()
    
    private var albumImg: UIImageView = {
        let img = UIImageView()
        return img
    }()

    var showButton : UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .darkGray
        bt.setTitle("View Album!", for: UIControl.State.normal)
        bt.layer.cornerRadius = bt.frame.size.width / 2;
        bt.clipsToBounds = true;
          return bt
      }()
    
    //**** labels have similar setup except for size and color
    private var artistName: UILabel = {
        let l = UILabel()
        l.customSetUp(color: .darkGray, fontSize: Constants.DetailsFonts.artistNameFont)
        return l
    }()

    private var albumName: UILabel = {
        let l = UILabel()
        l.customSetUp(fontSize: Constants.DetailsFonts.albumNameFont)
        return l
    }()

    private var releaseDate: UILabel = {
        let l = UILabel()
        l.customSetUp(color: .gray, fontSize: Constants.DetailsFonts.releaseDateFont)
        return l
      }()

    private var copyright: UILabel = {
        let l = UILabel()
        l.customSetUp(color: .gray,
                      fontSize: Constants.DetailsFonts.copyrighteFont)
        return l
    }()

    private var genre: UILabel = {
          let l = UILabel()
          l.customSetUp(color: .darkGray, fontSize: Constants.DetailsFonts.genreFont)
          return l
      }()
    //end labels ****//

    
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

        self.addSubview(scrollView)
        scrollView.addSubview(view)

        view.addSubview(albumImg)
        view.addSubview(albumName)
        view.addSubview(artistName)
        view.addSubview(copyright)
        view.addSubview(releaseDate)
        view.addSubview(genre)
        
        self.addSubview(showButton)
    }

    private func viewLayout(){
        let viewSize = self.frame.size
                
        scrollView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, enableInsets: true)
        
        view.anchor(top: scrollView.topAnchor, left: nil, bottom: scrollView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.frame.width, height: 0 , enableInsets: true)

        albumImg.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop:0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: viewSize.width , enableInsets: true)

        //set constraints for labels
        labelsLayout()

        showButton.anchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: dConstraints.inBetweenLabelPadding, paddingLeft: dConstraints.leftRightButtonPadding, paddingBottom: dConstraints.topBottomButtonPadding, paddingRight: dConstraints.leftRightButtonPadding, enableInsets: true)
        
    }
    
    //same constraints for all labels except the last label which ties to the bottom of view
    private func labelsLayout(){
        
        let viewsConst : [UIView] = [albumImg,albumName,releaseDate,artistName,genre,copyright]
        
        for i in 1..<viewsConst.count{
            let bottomConst = i == (viewsConst.count - 1) ? (view.bottomAnchor,2 * dConstraints.topBottomLabelPadding) : (nil,0)
            viewsConst[i].anchor(top: viewsConst[i-1].bottomAnchor,
                                 left: view.leftAnchor,
                                 bottom: bottomConst.0,
                                 right: view.rightAnchor,
                                 paddingTop: dConstraints.inBetweenLabelPadding,
                                 paddingLeft: dConstraints.leftRightLabelPadding,
                                 paddingBottom: bottomConst.1,
                                 paddingRight: dConstraints.leftRightLabelPadding,
                                 enableInsets: true)
        }
    }
}


