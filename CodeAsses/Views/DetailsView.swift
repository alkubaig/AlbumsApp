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
                albumImg.getImg(url: url)
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
    
    //Stack View
    var stackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.spacing   = Constants.DetailsConstraints.inBetweenLabelPadding
        return stackView
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
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(albumImg)
        stackView.addArrangedSubview(albumName)
        stackView.addArrangedSubview(artistName)
        stackView.addArrangedSubview(releaseDate)
        stackView.addArrangedSubview(genre)
        stackView.addArrangedSubview(copyright)
        
        self.addSubview(showButton)
    }

    private func viewLayout(){
        let viewSize = self.frame.size                

        showButton.anchor(bottom: bottomAnchor, paddingBottom: dConstraints.topBottomButtonPadding, enableInsets: true)
        showButton.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: dConstraints.leftRightButtonPadding, paddingRight: dConstraints.leftRightButtonPadding)
        
        scrollView.anchor(top: topAnchor, left: leftAnchor, bottom: showButton.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, enableInsets: true)

        albumImg.anchor(height: viewSize.width)
        
        view.anchor(top: scrollView.topAnchor, bottom: scrollView.bottomAnchor, paddingTop: 0, paddingBottom: 0, enableInsets: true)
        view.anchor(width: viewSize.width)
    
        stackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: dConstraints.topBottomLabelPadding, paddingLeft: dConstraints.leftRightLabelPadding, paddingBottom: 2 * dConstraints.topBottomLabelPadding, paddingRight: dConstraints.leftRightLabelPadding, enableInsets: true)
        
            
    }
    
}


