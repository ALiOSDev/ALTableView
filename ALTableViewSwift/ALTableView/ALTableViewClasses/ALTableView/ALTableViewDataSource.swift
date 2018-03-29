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
        
        return self.sectionElements.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.sectionElements[ALSafe: section]?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell: UITableViewCell = self.sectionElements[ALSafe: indexPath.section]?.getRowElementAt(index: indexPath.row)?.getViewFrom(tableView: tableView)  else {
            return UITableViewCell()
        }
        return cell
    }
}
