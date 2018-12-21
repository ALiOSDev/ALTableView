//
//  ALSectionElementRow.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 26/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

//MARK: - Getters
extension ALSectionElement {
    
    //MARK: - Get Cell View
    
    internal func getCellViewFrom(row: Int, tableView: UITableView) -> UITableViewCell? {
        
       return self.getRowElementAt(index: row)?.getViewFrom(tableView: tableView)
    }

    //MARK: - Managing height of cells
    
    internal func setRowElementHeight(row: Int, height: CGFloat) -> Void {
        
        self.getRowElementAt(index: row)?.setCellHeight(height: height)
    }
    
    internal func getRowHeight(at index: Int) -> CGFloat {
        
        return self.getRowElementAt(index: index)?.getHeight() ?? 0.0
    }
    
    internal func getRowEstimatedHeight(at index: Int) -> CGFloat {
        
        return self.getRowElementAt(index: index)?.getEstimatedHeight() ?? 0.0
    }
    
    //MARK: - Managing the insertion of new cells
    
    @discardableResult internal func insert(rowElements: Array<ALRowElement>, at position: ALPosition) -> Bool {

        return self.rowElements.safeInsert(contentsOf: rowElements, at: position)
    }
    
    //MARK: - Managing the deletion of new cells
    
    @discardableResult internal func deleteRowElements(numberOfRowElements: Int, at position: ALPosition) -> Bool {
        
        return self.rowElements.safeDelete(numberOfElements: numberOfRowElements, at:position)
    }
    
    //MARK: - Managing the replacement of new cells
    
    @discardableResult internal func replace(rowElements: Array<ALRowElement>, at position: ALPosition) -> Bool {
        
        return self.rowElements.safeReplace(contentsOf: rowElements, at: position)
    }
    
    //MARK: - Cell events
    
    internal func rowElementPressed(row: Int, viewController: UIViewController?, cell: UITableViewCell) {
        
        self.getRowElementAt(index: row)?.rowElementPressed(viewController: viewController, cell: cell)
    }
    
    internal func rowElementDeselected(row: Int, cell: UITableViewCell) {
        
        self.getRowElementAt(index: row)?.rowElementDeselected(cell: cell)
    }
}

//MARK: - Support methods

extension ALSectionElement {
    
    public func getRowElementAt(index: Int) -> ALRowElement? {
        
        return self.rowElements[ALSafe: index]
    }
}
