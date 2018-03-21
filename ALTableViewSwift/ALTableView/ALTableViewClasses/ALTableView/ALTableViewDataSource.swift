//
//  ALTableViewDataSource.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 16/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

//MARK: - UITableViewDataSource

extension ALTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        let numberOfSections: Int = self.sectionManager.getNumberOfSections()
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRows: Int = self.sectionManager.getNumberOfRows(in: section)
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: UITableViewCell = self.sectionManager.getCellFrom(tableView: tableView, indexPath: indexPath)  else {
            return UITableViewCell()
        }
        return cell
    }
}
