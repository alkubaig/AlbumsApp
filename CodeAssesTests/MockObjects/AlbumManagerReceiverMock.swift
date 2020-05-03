//
//  Mock.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 4/26/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

/****************************************
 ** objects for testing api maneger
****************************************/

//MARK:- enum of erros for testing

enum NetworkErr : Error {
    case noData
    case codeStatus(Int)
}

//MARK:- a mock object confirming to AlbumManagerDelegate

class AlbumManagerReceiverMock: AlbumManagerDelegate {

    let expectedBehaviorForDidLoadAlbum: (([Album]) -> Void)
    let expectedBehaviorFordidFailWithError: ((Error) -> Void)

    init(_ expectedBehaviorForDidLoadAlbum: @escaping (([Album]) -> Void),
         _ expectedBehaviorFordidFailWithError: @escaping ((Error) -> Void)) {
        
        //we take testing closures and pass them to delegate methods
        self.expectedBehaviorForDidLoadAlbum = expectedBehaviorForDidLoadAlbum
        self.expectedBehaviorFordidFailWithError = expectedBehaviorFordidFailWithError
    }
    //test didLoadAlbum
    func didLoadAlbum(albums: [Album]) {
        expectedBehaviorForDidLoadAlbum(albums)
    }
    //test didFailWithError
    func didFailWithError(error: Error) {
        expectedBehaviorFordidFailWithError(error)
    }

}

