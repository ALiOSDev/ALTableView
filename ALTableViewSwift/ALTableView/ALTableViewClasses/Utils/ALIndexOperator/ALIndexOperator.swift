//
//  ALIndexOperator.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 27/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import Foundation

enum ALPosition {
    case begining
    case end
    case middle(Int)
    
    func getValue() -> Int{
        switch self {
        case .middle(let value):
            return value
        default:
            return 0
        }
    }
}

enum ALOperation {
    
    case get
    case insert
    case delete
    case replace
    
    func getIndexOperator(position: ALPosition, elements: Array<Any>) -> ALIndexOperator {
        
        switch position {
        case ALPosition.begining:
            return self.getBeginingOperator()
        case ALPosition.end:
            return self.getEndOperator(elements: elements)
        case ALPosition.middle:
            return self.getMiddleOperator(index: position.getValue())
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












