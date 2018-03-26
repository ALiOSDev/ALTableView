//
//  ALSectionElementRow.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 26/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

extension ALSectionElement {
    
    //MARK: - Getters
    
    internal func getRowElementAt(position: Int) -> ALRowElement? {
        
        let rowElement: ALRowElement? = self.rowElements[ALSafe: position]
        return rowElement
    }
    
    internal func getRowHeight(at position: Int) -> CGFloat {
        
        return self.getRowElementAt(position: position)?.getHeight() ?? 0.0
    }
    
    internal func getRowEstimatedHeight(at position: Int) -> CGFloat {
        
        return self.getRowElementAt(position: position)?.getEstimatedHeight() ?? 0.0
    }
    
    //MARK: - Managing the insertion of new cells
    
    internal func insert(rowElements: Array<ALRowElement>, at index: Int) -> Bool {
        
        self.rowElements.insert(contentsOf: rowElements, at: index)
        return true
    }
    
    //MARK: - Managing the deletion of new cells
    
    internal func deleteRowElements(numberOfRowElements: Int, at index: Int) -> Bool {
        
        let endIndex: Int = index + numberOfRowElements
        guard self.rowElements.indices.contains(endIndex) else {
            return false
        }
        self.rowElements.removeSubrange(index...endIndex)
        return true
    }
    
    //MARK: - Managing the replacement of new cells
    
    internal func replace(rowElements: Array<ALRowElement>, at index: Int) -> Bool {
        
        guard self.deleteRowElements(numberOfRowElements: rowElements.count, at: index),
            self.insert(rowElements: rowElements, at: index) else {
                return false
        }
        return true
    }
}
