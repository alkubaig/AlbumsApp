//
//  ImgReteriveMock.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 4/30/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation

struct ImgReteriveMock: ImgReteriveProtocol {
    
    var completion: (() -> Void)
    
    init(_ complition: @escaping (()->Void)){
     
        self.completion = complition
    }
    
}
