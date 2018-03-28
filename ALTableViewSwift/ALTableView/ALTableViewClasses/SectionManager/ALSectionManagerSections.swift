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
        
        return self.sectionElements.safeInsert(contentsOf: sectionElements, at: section)
    }
    
    internal func delete(numberOfSectionElements: Int, section: Int) -> Bool {
        
        return self.sectionElements.safeDelete(numberOfElements: numberOfSectionElements, at:section)
    }
    
    internal func replace(sectionElements: Array<ALSectionElement>, section: Int) -> Bool {
        
        return self.sectionElements.safeReplace(contentsOf: sectionElements, at: section)
    }
    
    
    internal func replaceAllSections(sectionElements: Array<ALSectionElement>) {
        
        self.sectionElements = sectionElements
        self.sectionElements.forEach { (sectionElement: ALSectionElement) in
            sectionElement.delegate = self
        }
    }
    
}
