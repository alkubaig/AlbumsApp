//
//  ImgReteriveMock.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 4/30/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

/****************************************
 ** mock object for testing ImgReterive
****************************************/

import Foundation

//MARK:- a mock object confirming to ImgReteriveProtocol

struct ImgReteriveMock: ImgReteriveProtocol {
    
    var completion: (() -> Void)
    
    init(_ complition: @escaping (()->Void)){
        //set tesing closure
        self.completion = complition
    }
    
}
