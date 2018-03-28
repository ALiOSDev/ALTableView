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
        let index: Int = self.getRealIndex(operation: .get, index: index)
        return indices.contains(index) ? self[index] : nil
    }
    
    internal mutating func safeInsert<C>(contentsOf newElements: C, at i: Int) -> Bool where C : Collection, Element == C.Element {
        
        let index: Int = self.getRealIndex(operation: .insert, index: i)
        guard index >= 0 && index <= self.count else {
            return false
        }
        self.insert(contentsOf: newElements, at: index)
        return true
    }
    
    internal mutating func safeReplace<C>(contentsOf newElements: C, at i: Int) -> Bool where C: Collection, Element == C.Element {
        let initialIndex = i
        let finalIndex = i + Int(newElements.count)
        guard i >= 0,
            finalIndex <= self.count else {
            return false
        }
        

//        if finalIndex > self.count {
//            return false
//        }
        let headArray = self[0..<initialIndex]
        let tailArray = self[finalIndex..<self.count]
        self = headArray + Array(newElements) + tailArray

        return true
        
    }
    
    private func getRealIndex(operation: ALOperation, index: Int) -> Int {
        let indexOperator: ALIndexOperator = self.getIndexOperator(operation: operation, index: index)
        return indexOperator.calculateIndex()
        
    }
    
    private func getIndexOperator(operation: ALOperation, index: Int) -> ALIndexOperator {
        return operation.getIndexOperator(index: index, elements: self)
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
