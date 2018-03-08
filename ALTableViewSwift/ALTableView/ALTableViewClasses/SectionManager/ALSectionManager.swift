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
    func sectionOpened(at index: Int, numberOfElements: Int)
    func sectionClosed(at index: Int, numberOfElements: Int)
}

class ALSectionManager: ALSectionHeaderViewDelegate {
    
    //MARK: - Properties
    
    internal weak var delegate: ALSectionManagerProtocol?
    private var sectionElements: [ALSectionElement]
    
    //MARK: - Initializers
    
    init(sectionElements: Array<ALSectionElement>) {
        self.sectionElements = sectionElements
    }
    
    //MARK: - Number of Sections & Cells
    
    func getNumberOfSections() -> Int {
        return self.sectionElements.count
    }
    
    func getNumberOfRows(in section: Int) -> Int {
        guard section < self.sectionElements.count && section >= 0 else {
            return 0
        }
        return self.sectionElements[section].getNumberOfRows()
    }
    
    //MARK: - Cell height
    
    internal func getCellHeightFrom(indexPath: IndexPath) -> CGFloat {
        return self.getCellHeightFrom(section: indexPath.section, row: indexPath.row)
    }
    
    internal func getCellHeightFrom(section: Int, row: Int) -> CGFloat {
        guard section < self.sectionElements.count && section >= 0 else {
            return 0
        }
        if let rowHeight = self.sectionElements[section].getRowHeight(at: row) {
            return rowHeight
        }
        return 0
    }
    
    func setRowElementHeight(height: CGFloat, indexPath: IndexPath) {
        self.setRowElementHeight(height: height, section: indexPath.section, row: indexPath.row)
    }
    
    func setRowElementHeight(height: CGFloat, section: Int, row: Int) {
        if let rowElement: ALRowElement = self.getRowElementAtSection(section: section, row: row) {
            rowElement.setCellHeight(height: height)
        }
    }
    
    //MARK: - Get Row Elements
    
    internal func getRowElementAtIndexPath(indexPath: IndexPath) -> ALRowElement? {
        return self.getRowElementAtSection(section: indexPath.section, row: indexPath.row)
    }
    
    internal func getRowElementAtSection(section: Int, row: Int) -> ALRowElement? {
        let rowElement: ALRowElement? = self.sectionElements[section].getRowElementAt(position: row)
        return rowElement
    }
    

    
    //MARK: - ALSectionHeaderViewDelegate
    
    func sectionOpened(sectionElement: ALSectionElement) {
        if let index: Int = sectionElements.index(of: sectionElement) {
            let numberOfElements: Int = sectionElement.getNumberOfRealRows()
            self.delegate?.sectionOpened(at: index, numberOfElements: numberOfElements)
        }

    }
    
    func sectionClosed(sectionElement: ALSectionElement) {
        if let index: Int = sectionElements.index(of: sectionElement) {
            let numberOfElements: Int = sectionElement.getNumberOfRealRows()
            self.delegate?.sectionClosed(at: index, numberOfElements: numberOfElements)
        }
    }
    

}
