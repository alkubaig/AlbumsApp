//
//  TableViewDataSorce.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/31/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

class TableViewDataSorce<CellType,ViewModelType>: NSObject, UITableViewDataSource where CellType : UITableViewCell{
    
    let cellId : String
    var models = [ViewModelType]()
    let configCell : (CellType, ViewModelType) -> ()
    
    init(cellId: String, configCell: @escaping(CellType, ViewModelType)->()) {
        
        self.cellId = cellId
        self.configCell = configCell
    }
    
    //dependency injuction - property
    func updateModel(newModel: [ViewModelType]){
        models = newModel
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CellType {
        
        let vm = models[indexPath.row]
        configCell(cell,vm)
        return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
