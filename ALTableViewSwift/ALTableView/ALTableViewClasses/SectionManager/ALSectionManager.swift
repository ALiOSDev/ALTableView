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

class ALSectionManager: ALSectionHeaderViewDelegate {
    
    //MARK: - Properties
    
    internal weak var delegate: ALSectionManagerProtocol?
    private var sectionElements: [ALSectionElement]
    
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
        
        guard let numberOfRows = self.sectionElements[safe: section]?.getNumberOfRows() else {
            return 0
        }
        return numberOfRows
    }
    
    //MARK: - Getter Cell
    
    internal func getCellFrom(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        
        return self.getCellFrom(tableView: tableView, section: indexPath.section, row: indexPath.row)
    }
    
    internal func getCellFrom(tableView: UITableView, section: Int, row: Int) -> UITableViewCell? {
        
        guard let rowElement: ALRowElement = self.getRowElementAtSection(section: section, row: row)  else {
            return nil
        }
        let cell: UITableViewCell = rowElement.getViewFrom(tableView: tableView)
        return cell
    }
    
    //MARK: - Cell height
    
    internal func getCellHeightFrom(indexPath: IndexPath) -> CGFloat {
        
        return self.getCellHeightFrom(section: indexPath.section, row: indexPath.row)
    }
    
    internal func getCellHeightFrom(section: Int, row: Int) -> CGFloat {
        
        guard let rowHeight = self.sectionElements[safe: section]?.getRowHeight(at: row) else {
            return 0
        }
        return rowHeight
    }
    
    internal func setRowElementHeight(height: CGFloat, indexPath: IndexPath) {
        
        self.setRowElementHeight(height: height, section: indexPath.section, row: indexPath.row)
    }
    
    internal func setRowElementHeight(height: CGFloat, section: Int, row: Int) {
        
        guard let rowElement: ALRowElement = self.getRowElementAtSection(section: section, row: row) else {
            return
        }
        rowElement.setCellHeight(height: height)
    }
    
    //MARK: - Get Row Elements
    
    internal func getRowElementAtIndexPath(indexPath: IndexPath) -> ALRowElement? {
        
        return self.getRowElementAtSection(section: indexPath.section, row: indexPath.row)
    }
    
    internal func getRowElementAtSection(section: Int, row: Int) -> ALRowElement? {
        
        let rowElement: ALRowElement? = self.sectionElements[safe: section]?.getRowElementAt(position: row)
        return rowElement
    }
    
    //MARK: - Sections Header & Footer Views
    
    internal func getSectionHeaderAtIndexPath(indexPath: IndexPath) -> UIView? {
        
        return self.getSectionHeaderAtSection(section: indexPath.section)
    }
    
    internal func getSectionHeaderAtSection(section: Int) -> UIView? {
        
        let sectionElement: ALSectionElement? = self.sectionElements[safe: section]
        return sectionElement?.getHeader()
    }
    
    internal func getSectionFooterAtIndexPath(indexPath: IndexPath) -> UIView? {
        
        return self.getSectionFooterAtSection(section: indexPath.section)
    }
    
    internal func getSectionFooterAtSection(section: Int) -> UIView? {
        
        let sectionElement: ALSectionElement? = self.sectionElements[safe: section]
        return sectionElement?.getFooter()
    }

    //MARK: - Sections Header & Footer height

    internal func getSectionHeaderHeightAtIndexPath(indexPath: IndexPath) -> CGFloat {
        
        return self.getSectionHeaderHeightAtSection(section: indexPath.section)
    }
    
    internal func getSectionHeaderHeightAtSection(section: Int) -> CGFloat {
        
        guard let sectionElement: ALSectionElement = self.sectionElements[safe: section] else {
            return 0
        }
        return sectionElement.getHeaderHeight()
    }
    
    internal func getSectionFooterHeightAtIndexPath(indexPath: IndexPath) -> CGFloat {
        
        return self.getSectionFooterHeightAtSection(section: indexPath.section)
    }
    
    internal func getSectionFooterHeightAtSection(section: Int) -> CGFloat {
        
        guard let sectionElement: ALSectionElement = self.sectionElements[safe: section] else {
            return 0
        }
        return sectionElement.getFooterHeight()
    }
    
    //MARK: - ALSectionHeaderViewDelegate
    
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
    
    //MARK: - Managing rows
    
    internal func insert(rowElements: Array<ALRowElement>, section: Int, row: Int) -> Bool {
        
        guard let sectionElement: ALSectionElement = self.sectionElements[safe: section] else {
            return false
        }
        return sectionElement.insert(rowElements: rowElements, at: row)
    }
    
    internal func delete(numberOfRowElements: Int, section: Int, row: Int) -> Bool {
        
        guard let sectionElement: ALSectionElement = self.sectionElements[safe: section] else {
            return false
        }
        return sectionElement.deleteRowElements(numberOfRowElements: numberOfRowElements, at: row)
    }
    
    internal func replace(rowElements: Array<ALRowElement>, section: Int, row: Int) -> Bool {
        
        guard let sectionElement: ALSectionElement = self.sectionElements[safe: section] else {
            return false
        }
        return sectionElement.replace(rowElements: rowElements, at: row)
    }
    
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

extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
