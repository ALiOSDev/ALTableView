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
    
    internal func getRowElementAt(index: Int) -> ALRowElement? {
        
        return self.rowElements[ALSafe: index]
    }
    
    internal func getRowHeight(at index: Int) -> CGFloat {
        
        return self.getRowElementAt(index: index)?.getHeight() ?? 0.0
    }
    
    internal func getRowEstimatedHeight(at index: Int) -> CGFloat {
        
        return self.getRowElementAt(index: index)?.getEstimatedHeight() ?? 0.0
    }
    
    //MARK: - Managing the insertion of new cells
    
    internal func insert(rowElements: Array<ALRowElement>, at position: ALPosition) -> Bool {

        return self.rowElements.safeInsert(contentsOf: rowElements, at: position)
    }
    
    //MARK: - Managing the deletion of new cells
    
    internal func deleteRowElements(numberOfRowElements: Int, at position: ALPosition) -> Bool {
        
        return self.rowElements.safeDelete(numberOfElements: numberOfRowElements, at:position)
    }
    
    //MARK: - Managing the replacement of new cells
    
    internal func replace(rowElements: Array<ALRowElement>, at position: ALPosition) -> Bool {
        
        return self.rowElements.safeReplace(contentsOf: rowElements, at: position)
    }
}
