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
    
    func getIndexOperator(position: ALPosition, numberOfElements: Int) -> ALIndexOperator {
        
        switch position {
        case ALPosition.begining:
            return self.getBeginingOperator()
        case ALPosition.end:
            return self.getEndOperator(numberOfElements: numberOfElements)
        case ALPosition.middle:
            return self.getMiddleOperator(index: position.getValue())
        }
        
    }
    
    private func getBeginingOperator() -> ALIndexOperator {
        
        switch self {
        case .insert:
            return ALFirstPosition()
        default:
            return ALFirstElement()
        }
    }
    
    private func getEndOperator(numberOfElements: Int) -> ALIndexOperator {
        
        switch self {
        case .insert:
            return ALLastPosition(numberOfElements: numberOfElements)
        default:
            return ALLastElement(numberOfElements: numberOfElements)
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
    
    let numberOfElements: Int
    
    init(numberOfElements: Int) {
        
        self.numberOfElements = numberOfElements - 1
    }
    
    func calculateIndex() -> Int {
        
        return self.numberOfElements
    }
    
}

class ALLastPosition: ALIndexOperator {
    
    let numberOfElements: Int
    
    init(numberOfElements: Int) {
        
        self.numberOfElements = numberOfElements
    }
    
    func calculateIndex() -> Int {
        
        return self.numberOfElements
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












