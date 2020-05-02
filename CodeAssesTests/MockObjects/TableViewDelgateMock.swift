//
//  TableViewDelgateMock.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 5/1/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation

class TableViewDelgateMock: TableViewDelegateProtocol {
    
//    var completion: ((IndexPath) -> Void)
    var selected = false

//    init(_ complition: @escaping ((IndexPath)->Void)){
//
//        self.completion = complition
//    }
    
    func didSelectCell(indexPath: IndexPath) {
        selected = true
//        completion(indexPath)
    }
    
}
