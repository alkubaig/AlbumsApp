//
//  TableViewDelgateMock.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 5/1/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation

class TableViewDelgateMock: TableViewDelegateProtocol {
    
    var selected = false
    
    func didSelectCell(indexPath: IndexPath) {
        selected = true
    }
    
}
