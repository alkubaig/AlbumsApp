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

protocol TableViewDelegateProtocol {    
    func didSelectCell(indexPath: IndexPath)
}

class TableViewDatasourceDelegate<CellType,ViewModelType>: NSObject, UITableViewDataSource, UITableViewDelegate where CellType : UITableViewCell{
    
    var tableViewDelegateProtocol: TableViewDelegateProtocol?
    
    let cellId : String
    var models = [ViewModelType]()
    let configCell : (CellType, ViewModelType) -> ()
    
    //MARK:- intialization

    // dependecy injection - intializer
    init(cellId: String, configCell: @escaping(CellType, ViewModelType)->()) {
        self.cellId = cellId
        self.configCell = configCell
    }
    
    // dependency injuction - property
    func updateModel(newModel: [ViewModelType]){
        models = newModel
    }
    
    //MARK:- Datasource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // use configCell closure to configure the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CellType {
        let vm = models[indexPath.row]
        
        // we pass the corresponding cell and modelview to configCell to configure the cell
        configCell(cell,vm)
        
        return cell
        }
        return UITableViewCell()
    }
    
    //MARK:- Delegate methods

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

           return UITableView.automaticDimension
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //calll protocol method
        tableViewDelegateProtocol?.didSelectCell(indexPath: indexPath)
    }
    
}
