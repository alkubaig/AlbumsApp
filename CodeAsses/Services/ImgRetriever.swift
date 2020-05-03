//
//  Image+.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 4/14/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

/****************************************
 ** ImgRetriever: custom class that contains an ImgReteriveProtocol
 ** ImgRetriever extended with img loading methods.
 ** ImgReteriveProtocol: used to injuct a testing block
 ** imgCache: for storing images
****************************************/

// MARK:- chache<url,img>

let imgCache = NSCache<NSString,UIImage>()

// MARK:- protocol with complition block for testing
protocol ImgReteriveProtocol{

    var completion: (()->Void) { get set }
}

// MARK:- custom UIImageView with a protocol used to injuct a testing block

class ImgRetriever: UIImageView{
    
    //dependency injuction - property
    var imgReteriveProtocol : ImgReteriveProtocol?

    //default intializer
    init() {
        super.init(image: nil, highlightedImage: nil)
    }
    
    required init?(coder: NSCoder) {
       fatalError()
      }
}

// MARK:- ImgRetriever extended with loading img method

extension ImgRetriever{
    
    //check if image is in cache, otherwise, load and store in cache.
      func getImg(url: String){
          
          if let chachedImg = imgCache.object(forKey:NSString(string: url)){
              self.image = chachedImg
          }
          else {
              loadImgeURL(url: url)
          }
      }
    
    //asynch img loading
    func loadImgeURL(url: String){
        guard let img_url = URL(string: url) else{
            return
        }
        //use background threads to load image to avoid blocking UI
        DispatchQueue.global().async { [weak self] in
            do{
                
                let imgData = try Data(contentsOf: img_url)
                guard let imgToCache = UIImage(data: imgData) else{
                    print("no img")
                    self?.imgReteriveProtocol?.completion()
                    return
                }
                //update image in main thread
                DispatchQueue.main.async {
                    //put img in cache
                    imgCache.setObject(imgToCache, forKey: NSString(string: url))
                    self?.image = imgToCache
                    // run completion block from protocol
                    self?.imgReteriveProtocol?.completion()
                }

            } catch{
                print("can not load img")
            }
        }
    }
}
