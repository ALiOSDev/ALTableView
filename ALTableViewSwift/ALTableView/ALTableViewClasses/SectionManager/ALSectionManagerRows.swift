//
//  ALSectionManagerRows.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 26/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

extension ALSectionManager {
    
    //MARK: - Cell height
    
    internal func getCellHeightFrom(indexPath: IndexPath) -> CGFloat {
        
        return self.getCellHeightFrom(section: indexPath.section, row: indexPath.row)
    }
    
    internal func getCellHeightFrom(section: Int, row: Int) -> CGFloat {
        
        return self.sectionElements[ALSafe: section]?.getRowHeight(at: row) ?? 0.0
    }
    
    internal func getCellEstimatedHeightFrom(indexPath: IndexPath) -> CGFloat {
        
        return self.getCellEstimatedHeightFrom(section: indexPath.section, row: indexPath.row)
    }
    
    internal func getCellEstimatedHeightFrom(section: Int, row: Int) -> CGFloat {
        
        return self.sectionElements[ALSafe: section]?.getRowEstimatedHeight(at: row) ?? 0.0
    }
    
    internal func setRowElementHeight(height: CGFloat, indexPath: IndexPath) {
        
        self.setRowElementHeight(height: height, section: indexPath.section, row: indexPath.row)
    }
    
    internal func setRowElementHeight(height: CGFloat, section: Int, row: Int) {
        
        self.getRowElementAtSection(section: section, row: row)?.setCellHeight(height: height)
    }
    
    //MARK: - Getter Cell
    
    internal func getCellFrom(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        
        return self.getCellFrom(tableView: tableView, section: indexPath.section, row: indexPath.row)
    }
    
    internal func getCellFrom(tableView: UITableView, section: Int, row: Int) -> UITableViewCell? {
        
        return self.getRowElementAtSection(section: section, row: row)?.getViewFrom(tableView: tableView)
    }
    
    
    //MARK: - Get Row Elements
    
    internal func getRowElementAtIndexPath(indexPath: IndexPath) -> ALRowElement? {
        
        return self.getRowElementAtSection(section: indexPath.section, row: indexPath.row)
    }
    
    internal func getRowElementAtSection(section: Int, row: Int) -> ALRowElement? {
        
        let rowElement: ALRowElement? = self.sectionElements[ALSafe: section]?.getRowElementAt(index: row)
        return rowElement
    }
    
    //MARK: - Managing rows
    
    internal func insert(rowElements: Array<ALRowElement>, section: Int, position: ALPosition) -> Bool {
        
        guard let sectionElement: ALSectionElement = self.sectionElements[ALSafe: section] else {
            return false
        }
        
        return sectionElement.insert(rowElements: rowElements, at: position)
    }
    
    internal func delete(numberOfRowElements: Int, section: Int, position: ALPosition) -> Bool {
        
        guard let sectionElement: ALSectionElement = self.sectionElements[ALSafe: section] else {
            return false
        }
        return sectionElement.deleteRowElements(numberOfRowElements: numberOfRowElements, at: position)
    }
    
    internal func replace(rowElements: Array<ALRowElement>, section: Int, position: ALPosition) -> Bool {
        
        guard let sectionElement: ALSectionElement = self.sectionElements[ALSafe: section] else {
            return false
        }
        return sectionElement.replace(rowElements: rowElements, at: position)
    }
    
}
