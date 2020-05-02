//
//  Mock.swift
//  CodeAssesTests
//
//  Created by Ghadeer Alkubaish on 4/26/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

class AlbumManagerReceiverMock: AlbumManagerDelegate {

    let expectedBehaviorForDidLoadAlbum: (([Album]) -> Void)
    let expectedBehaviorFordidFailWithError: ((Error) -> Void)

    init(_ expectedBehaviorForDidLoadAlbum: @escaping (([Album]) -> Void),
         _ expectedBehaviorFordidFailWithError: @escaping ((Error) -> Void)) {
        self.expectedBehaviorForDidLoadAlbum = expectedBehaviorForDidLoadAlbum
        self.expectedBehaviorFordidFailWithError = expectedBehaviorFordidFailWithError
    }
    func didLoadAlbum(albums: [Album], completion: @escaping (() -> Void)) {
        expectedBehaviorForDidLoadAlbum(albums)
        completion()
    }
     
     func didFailWithError(error: Error) {
        expectedBehaviorFordidFailWithError(error)
    }

}

