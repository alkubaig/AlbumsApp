//
//  TableViewDataSorce.swift
//  CodeAsses
//
//  Created by Ghadeer Alkubaish on 3/31/20.
//  Copyright © 2020 Ghadeer Alkubaish. All rights reserved.
//

import UIKit

/****************************************
 ** a generic class for UITableViewDataSource that
 ** works with a custom cell type and a view model type
 ****************************************/

class TableViewDataSorce<CellType,ViewModelType>: NSObject, UITableViewDataSource where CellType : UITableViewCell{
    
    let cellId : String
    var models = [ViewModelType]()
    let configCell : (CellType, ViewModelType) -> ()
    
    // dependecy injection - intializer
    init(cellId: String, models: [ViewModelType], configCell: @escaping(CellType, ViewModelType)->()) {
        self.cellId = cellId
        self.configCell = configCell
        self.models = models
    }
    
    // dependency injuction - property
    func updateModel(newModel: [ViewModelType]){
        models = newModel
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
   // use configCell closure to configure the cell
    // we pass the corresponding cell and model view to configCell to configure the cell 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("data source2")

       if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CellType {
        
        print("data source")
        let vm = models[indexPath.row]
        configCell(cell,vm)
        return cell
        }
        return UITableViewCell()
    }
}
