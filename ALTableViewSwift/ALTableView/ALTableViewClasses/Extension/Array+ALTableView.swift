//
//  Array+ALTableView.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 27/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import Foundation


extension Array {
    

    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.

    internal subscript (ALSafe index: Index) -> Element? {
        
        let position: ALPosition = ALPosition.middle(index)
        return self[ALSafePosition: position]
    }
    
    internal subscript (ALSafePosition position: ALPosition) -> Element? {
        
        let index: Int = self.getRealIndex(operation: .get, position: position)
        return indices.contains(index) ? self[index] : nil
    }
    
    internal mutating func safeInsert<C>(contentsOf newElements: C, at i: Int) -> Bool where C : Collection, Element == C.Element {
        
        let position: ALPosition = ALPosition.middle(i)
        return self.safeInsert(contentsOf: newElements, at: position)
    }
    
    internal mutating func safeInsert<C>(contentsOf newElements: C, at position: ALPosition) -> Bool where C : Collection, Element == C.Element {
        
        let index: Int = self.getRealIndex(operation: .insert, position: position)
        guard index >= 0 && index <= self.count else {
            return false
        }
        self.insert(contentsOf: newElements, at: index)
        return true
    }
    
    internal mutating func safeReplace<C>(contentsOf newElements: C, at i: Int) -> Bool where C: Collection, Element == C.Element {
        
        let position: ALPosition = ALPosition.middle(i)
        return self.safeReplace(contentsOf: newElements, at: position)
    }
    
    internal mutating func safeReplace<C>(contentsOf newElements: C, at position: ALPosition) -> Bool where C: Collection, Element == C.Element {
        
        let initialIndex = self.getRealIndex(operation: .replace, position: position)
        let finalIndex = initialIndex + Int(newElements.count)
        guard initialIndex >= 0,
            finalIndex <= self.count else {
                return false
        }
        
        let headArray = self[0..<initialIndex]
        let tailArray = self[finalIndex..<self.count]
        self = Array(headArray + newElements + tailArray)
        
        return true
        
    }
    
    internal mutating func safeDelete(numberOfElements: Int, at i: Int) -> Bool {
        
        let position: ALPosition = ALPosition.middle(i)
        return self.safeDelete(numberOfElements: numberOfElements, at: position)
    }
    
    internal mutating func safeDelete(numberOfElements: Int, at position: ALPosition) -> Bool {
        
        let initialIndex = self.getRealIndex(operation: .delete, position: position)
        let finalIndex = initialIndex + numberOfElements
        guard initialIndex >= 0,
            finalIndex <= self.count else {
                return false
        }
        let headArray = self[0..<initialIndex]
        let tailArray = self[finalIndex..<self.count]
        self = Array(headArray + tailArray)
        
        return true
    }
    
    private func getRealIndex(operation: ALOperation, position: ALPosition) -> Int {
        
        let indexOperator: ALIndexOperator = self.getIndexOperator(operation: operation, position: position)
        return indexOperator.calculateIndex()
        
    }
    
    private func getIndexOperator(operation: ALOperation, position: ALPosition) -> ALIndexOperator {
        
        return operation.getIndexOperator(position: position, numberOfElements: self.count)
    }
    

    
}

extension Array where Element: Equatable {
    
    /// SwifterSwift: Check if array contains an array of elements.
    ///
    ///        [1, 2, 3, 4, 5].contains([1, 2]) -> true
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].contains([2, 6]) -> false
    ///        ["h", "e", "l", "l", "o"].contains(["l", "o"]) -> true
    ///
    /// - Parameter elements: array of elements to check.
    /// - Returns: true if array contains all given items.
    internal func contains(_ elements: [Element]) -> Bool {
        guard !elements.isEmpty else { return true }
        var found = true
        for element in elements {
            if !self.contains(element) {
                found = false
            }
        }
        return found
    }
}
