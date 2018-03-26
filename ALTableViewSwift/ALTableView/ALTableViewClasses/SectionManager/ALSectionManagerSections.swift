//
//  ALSectionManagerSections.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 26/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

extension ALSectionManager {
    
    //MARK: - Managing sections
    
    internal func insert(sectionElements: Array<ALSectionElement>, section: Int) -> Bool {
        
        self.sectionElements.insert(contentsOf: sectionElements, at: section)
        return true
    }
    
    internal func delete(numberOfSectionElements: Int, section: Int) -> Bool {
        
        let endIndex: Int = section + numberOfSectionElements
        guard self.sectionElements.indices.contains(endIndex) else {
            return false
        }
        self.sectionElements.removeSubrange(section...endIndex)
        return true
    }
    
    internal func replace(sectionElements: Array<ALSectionElement>, section: Int) -> Bool {
        
        guard self.delete(numberOfSectionElements: sectionElements.count, section: section),
            self.insert(sectionElements: sectionElements, section: section) else {
                return false
        }
        return true
    }
    
    
    internal func replaceAllSections(sectionElements: Array<ALSectionElement>) {
        
        self.sectionElements = sectionElements
        self.sectionElements.forEach { (sectionElement: ALSectionElement) in
            sectionElement.delegate = self
        }
    }
    
}
