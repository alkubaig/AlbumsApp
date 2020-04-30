//
//  ImgReteriveProtocolMock.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 4/30/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation

struct ImgReteriveProtocolMock: ImgReteriveProtocol {
    var complition: (() -> Void)
    
    init(_ complition: @escaping (()->Void)){
     
        self.complition = complition
    }
    
}
