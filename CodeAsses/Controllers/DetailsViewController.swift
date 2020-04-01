//
//  DetailsViewController.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/3/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit
class DetailsViewController: UIViewController {

    private var detailsView : DetailsView?

    var albumModel : AlbumViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @objc func viewAlbum(sender: UIButton) {
        
         if let url = albumModel?.url, let valid_url = URL(string: url),
            UIApplication.shared.canOpenURL(valid_url) {
                UIApplication.shared.open(valid_url)
         }else{
            print("Error")
        }
    }

    func configureView(){
        detailsView = DetailsView(frame: self.view.frame)
        if let detailsView = detailsView{
            self.view.addSubview(detailsView)
            detailsView.albumModel = self.albumModel
            detailsView.showButton.addTarget(self, action: #selector(viewAlbum), for: UIControl.Event.touchUpInside)
        }
    }
}
