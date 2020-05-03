//
//  DetailsViewController.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/3/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit
class DetailsViewController: UIViewController {

    let albumModel : AlbumDetailsViewModel

     var detailsView : DetailsView?{
        
        didSet{
            //update UI after viwModel is set
            if let detailsView = detailsView{
                self.view.addSubview(detailsView)
                detailsView.albumViewModel = self.albumModel
                //attach action method to button
                detailsView.showButton.addTarget(self, action: #selector(viewAlbum), for: UIControl.Event.touchUpInside)
            }
        }
    }

    //dependency injuction - intilizer
    init(albumModel: AlbumDetailsViewModel) {
        self.albumModel = albumModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) can not be implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsView = DetailsView(frame: self.view.frame)
    }
    // action for clicking the button
    @objc func viewAlbum(sender: UIButton) {
        
        let url = albumModel.url
        //open web application
        if let valid_url = URL(string: url),
            UIApplication.shared.canOpenURL(valid_url) {
                UIApplication.shared.open(valid_url)
         }else{
            print("Error")
        }
    }

}
