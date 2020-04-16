//
//  Image+.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 4/14/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

let imgCache = NSCache<NSString,UIImage>()

extension UIImageView{
    
    //check if image is in cache, otherwise, load and store in cache.
    func loadImgeURL(url: String){
        
        if let chachedImg = imgCache.object(forKey:NSString(string: url)){
            self.image = chachedImg
        }
        else {
            loadImgeURL_(url: url)
        }
    }
    
    //load and store in cache.
    func loadImgeURL_(url: String){
        
        if let img_url = URL(string: url){
            
            //use threads to load image to avoid blocking UI
            DispatchQueue.global().async { [weak self] in
                do{
                    let imgData = try Data(contentsOf: img_url)
                    guard let imgToCache = UIImage(data: imgData) else{
                        print("no img")
                        return
                    }
                    //update image in main thread
                    DispatchQueue.main.async {
                        imgCache.setObject(imgToCache, forKey: NSString(string: url))
                        self?.image = imgToCache
                    }
                    
                } catch{
                    print("can not load img")
                }
            }
        }
    }
    
}


