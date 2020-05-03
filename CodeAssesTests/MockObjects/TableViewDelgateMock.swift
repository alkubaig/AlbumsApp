//
//  TableViewDelgateMock.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 5/1/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import Foundation

/****************************************
 ** Mock object for testing TableViewDelgate
****************************************/

//MARK:- a mock object confirming to TableViewDelegateProtocol

class TableViewDelgateMock: TableViewDelegateProtocol {
    
    var selected = false
    
    func didSelectCell(indexPath: IndexPath) {
        //chnage propery selected to true when delegate method is triggred
        selected = true
    }
    
}
