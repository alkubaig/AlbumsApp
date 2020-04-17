//
//  DetailsViewController.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/3/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit
class DetailsViewController: UIViewController {

    var albumModel : AlbumDetailsViewModel?

    private var detailsView : DetailsView?{
        
        didSet{
            if let detailsView = detailsView{
                self.view.addSubview(detailsView)
                detailsView.albumModel = self.albumModel
                detailsView.showButton.addTarget(self, action: #selector(viewAlbum), for: UIControl.Event.touchUpInside)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsView = DetailsView(frame: self.view.frame)
    }
    
    @objc func viewAlbum(sender: UIButton) {
        
         if let url = albumModel?.url, let valid_url = URL(string: url),
            UIApplication.shared.canOpenURL(valid_url) {
                UIApplication.shared.open(valid_url)
         }else{
            print("Error")
        }
    }

}

//extension UIViewController {
//
//    /**
//     *  Height of status bar + navigation bar (if navigation bar exist)
//     */
//
//    var topbarHeight: CGFloat {
//        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
//            (self.navigationController?.navigationBar.frame.height ?? 0.0)
//    }
//}
