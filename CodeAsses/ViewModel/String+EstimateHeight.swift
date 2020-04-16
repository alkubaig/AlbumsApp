//
//  String+EstimateHeight.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 4/15/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

extension String{
    func estimateTextHeight(fontSize: CGFloat, approxWidth: CGFloat)-> CGFloat{
        
        let size = CGSize(width: approxWidth, height: 1000)
        let attr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize) ]
        let estimatedframe = NSString(string: self).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attr, context: nil)
        
        return estimatedframe.height
    }
    
}
