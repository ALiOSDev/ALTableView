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
        self.sectionElements.forEach { (sectionElement: ALSectionElement) in
            sectionElement.delegate = self
        }
    }
    
    //MARK: - Number of Sections & Cells
    
    internal func getNumberOfSections() -> Int {
        return self.sectionElements.count
    }
    
    internal func getNumberOfRows(in section: Int) -> Int {
        guard section < self.sectionElements.count && section >= 0 else {
            return 0
        }
        return self.sectionElements[section].getNumberOfRows()
    }
    
    //MARK: - Getter Cell
    
    internal func getCellFrom(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        return self.getCellFrom(tableView: tableView, section: indexPath.section, row: indexPath.row)
    }
    
    internal func getCellFrom(tableView: UITableView, section: Int, row: Int) -> UITableViewCell? {
        guard section < self.sectionElements.count && section >= 0 else {
            return nil
        }
        if let rowElement: ALRowElement = self.getRowElementAtSection(section: section, row: row) {
            let cell: UITableViewCell = rowElement.getCellFrom(tableView: tableView)
            return cell
        }
        return nil
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
    
    internal func setRowElementHeight(height: CGFloat, indexPath: IndexPath) {
        self.setRowElementHeight(height: height, section: indexPath.section, row: indexPath.row)
    }
    
    internal func setRowElementHeight(height: CGFloat, section: Int, row: Int) {
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
        if let sectionElement: ALSectionElement = self.sectionElements[safe: section] {
            return sectionElement.getHeaderHeight()
        }
        return 0
    }
    
    internal func getSectionFooterHeightAtIndexPath(indexPath: IndexPath) -> CGFloat {
        return self.getSectionFooterHeightAtSection(section: indexPath.section)
    }
    
    internal func getSectionFooterHeightAtSection(section: Int) -> CGFloat {
        if let sectionElement: ALSectionElement = self.sectionElements[safe: section] {
            return sectionElement.getFooterHeight()
        }
        return 0
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

extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
