//
//  SectionManager.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 7/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

//Implemented by ALTableView
protocol ALSectionManagerProtocol: class {
    func sectionOpened(at section: Int, numberOfElements: Int)
    func sectionClosed(at section: Int, numberOfElements: Int)
}

class ALSectionManager {
    
    //MARK: - Properties
    
    internal weak var delegate: ALSectionManagerProtocol?
    internal var sectionElements: [ALSectionElement]
    
    //MARK: - Initializers
    
    init(sectionElements: Array<ALSectionElement>) {
        
        self.sectionElements = sectionElements
        self.sectionElements.forEach { (sectionElement: ALSectionElement) in
            sectionElement.delegate = self
        }
    }
    
    //MARK: - Number of Sections & Cells
    
    internal func getNumberOfSections() -> Int {
        return self.sectionElements.count
    }
    
    internal func getNumberOfRows(in section: Int) -> Int {
        
        return self.sectionElements[ALSafe: section]?.getNumberOfRows() ?? 0
    }
    
}

//MARK: - ALSectionHeaderViewDelegate

extension ALSectionManager: ALSectionHeaderViewDelegate {
    
    func sectionOpened(sectionElement: ALSectionElement) {
        
        guard let section: Int = sectionElements.index(of: sectionElement) else {
            return
        }
        let numberOfElements: Int = sectionElement.getNumberOfRealRows()
        self.delegate?.sectionOpened(at: section, numberOfElements: numberOfElements)
    }
    
    func sectionClosed(sectionElement: ALSectionElement) {
        
        guard let section: Int = sectionElements.index(of: sectionElement) else {
            return
        }
        let numberOfElements: Int = sectionElement.getNumberOfRealRows()
        self.delegate?.sectionClosed(at: section, numberOfElements: numberOfElements)
    }
}


