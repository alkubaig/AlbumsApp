//
//  DetailsView.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/10/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation
import UIKit

/****************************************
 ** a custom class for album details view
****************************************/

class DetailsView: UIView {

    //dependency injuction - property
    var albumViewModel : AlbumDetailsViewModel?{
        didSet {
            // when the view model is set, UI elements are set
            if let url = albumViewModel?.imgUrl{
                //get the image from the cache
                albumImg.getImg(url: url)
            }
            artistName.text = albumViewModel?.artistName
            albumName.text = albumViewModel?.albumName
            copyright.text = albumViewModel?.copyright
            releaseDate.text = albumViewModel?.releaseDate
            genre.text = albumViewModel?.genres
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
    
    //scroll view's content view
    private var view: UIView = {
         let view = UIView()
         return view
     }()

    var showButton : UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .darkGray
        bt.setTitle("View Album!", for: UIControl.State.normal)
        bt.layer.cornerRadius = bt.frame.size.width / 2;
        bt.clipsToBounds = true;
          return bt
      }()
    
    //Stack View and its content
    var stackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.spacing   = Constants.DetailsConstraints.inBetweenLabelPadding
        return stackView
    }()
    
    var albumImg: ImgRetriever = {
        let img = ImgRetriever()
        img.accessibilityIdentifier = Constants.DetailsElementId.albumImgId
        return img
    }()
    
    //**** labels 
    var artistName: UILabel = {
        let l = UILabel()
        l.textColor = .darkGray
        l.font = UIFont.systemFont(ofSize: Constants.DetailsFonts.artistNameFont)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.accessibilityIdentifier = Constants.DetailsElementId.artistNameId

        return l
    }()

    var albumName: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: Constants.DetailsFonts.albumNameFont)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.accessibilityIdentifier = Constants.DetailsElementId.albumNameId
        return l
    }()

    var releaseDate: UILabel = {
        let l = UILabel()
        l.textColor = .gray
        l.font = UIFont.systemFont(ofSize: Constants.DetailsFonts.releaseDateFont)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.accessibilityIdentifier = Constants.DetailsElementId.releaseDateId
        return l
      }()

    var copyright: UILabel = {
        let l = UILabel()
        l.textColor = .gray
        l.font = UIFont.systemFont(ofSize: Constants.DetailsFonts.copyrighteFont)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.accessibilityIdentifier = Constants.DetailsElementId.copyrightId
        return l
    }()

    var genre: UILabel = {
        let l = UILabel()
        l.textColor = .darkGray
        l.font = UIFont.systemFont(ofSize: Constants.DetailsFonts.genreFont)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.accessibilityIdentifier = Constants.DetailsElementId.genreId
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
        
        //stack view's content views
        stackView.addArrangedSubview(albumImg)
        stackView.addArrangedSubview(albumName)
        stackView.addArrangedSubview(artistName)
        stackView.addArrangedSubview(releaseDate)
        stackView.addArrangedSubview(genre)
        stackView.addArrangedSubview(copyright)
        
        //button is fixed in place
        self.addSubview(showButton)
    }

    private func viewLayout(){
        
        let viewSize = self.frame.size                

        //fix button in bottom
        showButton.anchor(bottom: bottomAnchor, paddingBottom: dConstraints.topBottomButtonPadding, enableInsets: true)
        showButton.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: dConstraints.leftRightButtonPadding, paddingRight: dConstraints.leftRightButtonPadding)
        
        scrollView.anchor(top: topAnchor, left: leftAnchor, bottom: showButton.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, enableInsets: true)

        //set the height of img to the width of the view
        albumImg.anchor(height: viewSize.width)
        
        view.anchor(top: scrollView.topAnchor, bottom: scrollView.bottomAnchor, paddingTop: 0, paddingBottom: 0, enableInsets: true)
        view.anchor(width: viewSize.width)
    
        stackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: dConstraints.topBottomLabelPadding, paddingLeft: dConstraints.leftRightLabelPadding, paddingBottom: 2 * dConstraints.topBottomLabelPadding, paddingRight: dConstraints.leftRightLabelPadding, enableInsets: true)
    }
    
}
