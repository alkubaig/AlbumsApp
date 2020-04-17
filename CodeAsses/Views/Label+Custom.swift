//
//  Label+Custom.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 4/16/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

extension UILabel{
    
    func customSetUp(color: UIColor, fontSize: CGFloat){
        
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: fontSize)
        setup()
    }
    
    func customSetUp(color: UIColor){
         
         self.textColor = color
         setup()
     }
    
    func customSetUp(fontSize: CGFloat){
        
        self.font = UIFont.systemFont(ofSize: fontSize)
        setup()
    }
    
    func setup(){
        self.textAlignment = .center
        self.numberOfLines = 0
    }
    
}
