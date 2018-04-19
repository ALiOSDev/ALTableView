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
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.sectionElements.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.getSectionElementAt(index: section)?.getNumberOfRows() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.getSectionElementAt(index: indexPath.section)?.getCellViewFrom(row: indexPath.row, tableView: tableView) ?? UITableViewCell()
    }
}
