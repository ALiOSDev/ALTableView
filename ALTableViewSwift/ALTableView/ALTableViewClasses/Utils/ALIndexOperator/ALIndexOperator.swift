//
//  ALIndexOperator.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 27/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import Foundation

enum ALOperation {
    
    case get
    case insert
    case delete
    case replace
    
    func getIndexOperator(index: Int, elements: Array<Any>) -> ALIndexOperator {
        
        switch index {
        case ALPosition.begining.rawValue:
            return self.getBeginingOperator()
        case ALPosition.end.rawValue:
            return self.getEndOperator(elements: elements)
        default:
            return self.getMiddleOperator(index: index)
        }
        
    }
    
    private func getBeginingOperator() -> ALIndexOperator {
        
        return ALFirstPosition()
    }
    
    private func getEndOperator(elements: Array<Any>) -> ALIndexOperator {
        
        switch self {
        case .insert:
            return ALLastPosition(elements: elements)
        default:
            return ALLastElement(elements: elements)
        }
    }
    
    private func getMiddleOperator(index: Int) -> ALIndexOperator {
        
        return ALMiddlePosition(index: index)
    }
}


protocol ALIndexOperator {
    
    func calculateIndex() -> Int
}

class ALLastElement: ALIndexOperator {
    
    let elements: Array<Any>
    
    init(elements: Array<Any>) {
        
        self.elements = elements
    }
    
    func calculateIndex() -> Int {
        
        return self.elements.count - 1
    }
    
}

class ALLastPosition: ALIndexOperator {
    let elements: Array<Any>
    
    init(elements: Array<Any>) {
        
        self.elements = elements
    }
    
    func calculateIndex() -> Int {
        
        return self.elements.count
    }
    
}

class ALFirstElement: ALIndexOperator {
    
    func calculateIndex() -> Int {
        
        return 0
    }
    
}

class ALFirstPosition: ALIndexOperator {
    
    func calculateIndex() -> Int {
        
        return 0
    }
    
}

class ALMiddlePosition: ALIndexOperator {
    
    let index: Int
    
    init(index: Int) {
        
        self.index = index
    }
    
    func calculateIndex() -> Int {
        
        return self.index
    }
    
}












