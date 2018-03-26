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
        
        let index: Int = self.getRealIndexGet(index: index)
        guard self.isCorrectIndexGet(index: index, numberOfElements: self.rowElements.count) else {
            return nil
        }
        
        let rowElement: ALRowElement? = self.rowElements[ALSafe: index]
        return rowElement
    }
    
    internal func getRowHeight(at index: Int) -> CGFloat {
        
        let index = self.getRealIndexGet(index: index)
        guard self.isCorrectIndexGet(index: index, numberOfElements: self.rowElements.count) else {
            return 0.0
        }
        
        return self.getRowElementAt(index: index)?.getHeight() ?? 0.0
    }
    
    internal func getRowEstimatedHeight(at index: Int) -> CGFloat {
        
        let index = self.getRealIndexGet(index: index)
        guard self.isCorrectIndexGet(index: index, numberOfElements: self.rowElements.count) else {
            return 0.0
        }
        
        return self.getRowElementAt(index: index)?.getEstimatedHeight() ?? 0.0
    }
    
    //MARK: - Managing the insertion of new cells
    
    internal func insert(rowElements: Array<ALRowElement>, at index: Int) -> Bool {
        let index = self.getRealIndexInsert(index: index)
        
        guard self.isCorrectIndexInsert(index: index, numberOfElements: self.rowElements.count) else {
            return false
        }
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
        
        let index = self.getRealIndexInsert(index: index)
        
        guard self.deleteRowElements(numberOfRowElements: rowElements.count, at: index),
            self.insert(rowElements: rowElements, at: index) else {
                return false
        }
        return true
    }
    
    private func getRealIndexInsert(index: Int) -> Int {
        switch index {
        case ALPosition.begining.rawValue:
            return 0
        case ALPosition.end.rawValue:
            return self.rowElements.count
        default:
            return index
        }
    }
    
    private func getRealIndexGet(index: Int) -> Int {
        switch index {
        case ALPosition.begining.rawValue:
            return 0
        case ALPosition.end.rawValue:
            return self.rowElements.count - 1
        default:
            return index
        }
    }
    
    private func isCorrectIndexInsert(index: Int, numberOfElements: Int) -> Bool {
        return index <= numberOfElements && index >= 0
    }
    
    private func isCorrectIndexGet(index: Int, numberOfElements: Int) -> Bool {
        return index < numberOfElements && index >= 0
    }
}
