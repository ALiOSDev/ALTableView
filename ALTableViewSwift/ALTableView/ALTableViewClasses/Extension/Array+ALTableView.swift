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
        let index: Int = getRealIndexGet(index: index)
        return indices.contains(index) ? self[index] : nil
    }
    
    
    internal mutating func safeInsert<C>(contentsOf newElements: C, at i: Int) -> Bool where C : Collection, Element == C.Element {
        
        let index: Int = getRealIndexInsert(index: i)
        guard index >= 0 && index <= self.count else {
            return false
        }
        self.insert(contentsOf: newElements, at: index)
        return true
    }
    
    private func getRealIndexInsert(index: Int) -> Int {
        
        switch index {
        case ALPosition.begining.rawValue:
            return 0
        case ALPosition.end.rawValue:
            return self.count
        default:
            return index
        }
    }
    
    private func getRealIndexGet(index: Int) -> Int {
        
        switch index {
        case ALPosition.begining.rawValue:
            return 0
        case ALPosition.end.rawValue:
            return self.count - 1
        default:
            return index
        }
    }
    
}
