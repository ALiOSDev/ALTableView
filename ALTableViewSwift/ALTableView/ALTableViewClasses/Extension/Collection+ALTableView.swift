//
//  Collection+ALTableView.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 26/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import Foundation

extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (ALSafe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
