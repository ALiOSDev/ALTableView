//
//  ALTableViewSectionManaging.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 16/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

//MARK: - Managing the insertion of new sections

extension ALTableView {
    
    private func insert(sectionElements: Array<ALSectionElement>, position: ALPosition, animation: UITableView.RowAnimation = .top) -> Bool {
        
        guard self.sectionElements.safeInsert(contentsOf: sectionElements, at: position) else {
            return false
        }
        let indexSection = self.getIndexSections(position: position, numberOfSectionElements: sectionElements.count, operation: .replace)
        self.tableView?.beginUpdates()
        self.tableView?.insertSections(indexSection, with: animation)
        self.tableView?.endUpdates()
        return true
    }
    
    private func insert(sectionElement: ALSectionElement, position: ALPosition, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: [sectionElement], position: position, animation: animation)
    }
    
    @discardableResult public func insert(sectionElements: Array<ALSectionElement>, section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: sectionElements, position: .middle(section), animation: animation)
    }
    
    @discardableResult public func insert(sectionElement: ALSectionElement, at indexPath: IndexPath, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(sectionElement: sectionElement, section: indexPath.section, animation: animation)
    }
    
    @discardableResult public func insert(sectionElement: ALSectionElement, section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: [sectionElement], section: section, animation: animation)
    }
    
    @discardableResult public func insert(sectionElements: Array<ALSectionElement>, at indexPath: IndexPath, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: sectionElements, section: indexPath.section, animation: animation)
    }
    
    @discardableResult public func insert(sectionElement: ALSectionElement, atTheBeginingOfTableView section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(sectionElement: sectionElement, position: .begining)
    }
    
    @discardableResult public func insert(sectionElements: Array<ALSectionElement>, atTheBeginingOfTableView section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: sectionElements, position: .begining)
    }
    
    @discardableResult public func insert(sectionElement: ALSectionElement, atTheEndOfTableView section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(sectionElement: sectionElement, position: .end)
    }
    
    @discardableResult public func insert(sectionElements: Array<ALSectionElement>, atTheEndOfTableView section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: sectionElements, position: .end)
    }
}

//MARK: - Managing the removal of new sections

extension ALTableView {
    
    private func remove(sectionElements: Int, position: ALPosition, animation: UITableView.RowAnimation = .top) -> Bool {
        
        guard self.sectionElements.safeDelete(numberOfElements: sectionElements, at:position) else {
            return false
        }
        let indexSection = self.getIndexSections(position: position, numberOfSectionElements: sectionElements, operation: .replace)
        self.tableView?.beginUpdates()
        self.tableView?.deleteSections(indexSection, with: animation)
        self.tableView?.endUpdates()
        return true
    }
    
    private func remove(position: ALPosition, animation: UITableView.RowAnimation = .top) -> Bool {

        return self.remove(sectionElements: 1, position: position, animation: animation)
    }
    
    @discardableResult public func remove(sectionElements: Int, section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        return self.remove(sectionElements: sectionElements, position: .middle(section), animation: animation)
    }
    
    @discardableResult public func removeSection(at indexPath: IndexPath, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(sectionElements: 1, section: indexPath.section, animation: animation)
    }
    
    @discardableResult public func remove(section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(sectionElements: 1, section: section, animation: animation)
    }
    
    @discardableResult public func remove(sectionElements: Int, at indexPath: IndexPath, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(sectionElements: sectionElements, section: indexPath.section, animation: animation)
    }
    
    @discardableResult public func remove(satTheBeginingOfTableView section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(position: .begining, animation: animation)
    }
    
    @discardableResult public func remove(sectionElements: Int, atTheBeginingOfTableView section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(sectionElements: sectionElements, position: .begining, animation: animation)
    }
    
    @discardableResult public func remove(atTheEndOfTableView section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(position: .end, animation: animation)
    }
    
    @discardableResult public func remove(sectionElements: Int, atTheEndOfTableView section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(sectionElements: sectionElements, position: .end, animation: animation)
    }
}

//MARK: - Managing the replacement of new sections

extension ALTableView {
    
    private func replace(sectionElements: Array<ALSectionElement>, position: ALPosition, animation: UITableView.RowAnimation = .top) -> Bool {
        
        guard self.sectionElements.safeReplace(contentsOf: sectionElements, at: position) else {
            return false
        }
        let indexSection = self.getIndexSections(position: position, numberOfSectionElements: sectionElements.count, operation: .replace)
        self.tableView?.beginUpdates()
        self.tableView?.reloadSections(indexSection, with: animation)
        self.tableView?.endUpdates()
        return true
    }
    
    private func replace(sectionElement: ALSectionElement, position: ALPosition, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.replace(sectionElements: [sectionElement], position: position, animation: animation)
    }
    
    @discardableResult public func replace(sectionElements: Array<ALSectionElement>, section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.replace(sectionElements: sectionElements, position: .middle(section), animation: animation)
    }
    
    @discardableResult public func replace(sectionElement: ALSectionElement, at indexPath: IndexPath, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.replace(sectionElement: sectionElement, section: indexPath.section, animation: animation)
    }
    
    @discardableResult public func replace(sectionElement: ALSectionElement, section: Int,  animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.replace(sectionElements: [sectionElement], section: section, animation: animation)
        
    }
    
    @discardableResult public func replace(sectionElements: Array<ALSectionElement>, at indexPath: IndexPath, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.replace(sectionElements: sectionElements, section: indexPath.section, animation: animation)
    }
    
    public func replaceAllSections(sectionElements: Array<ALSectionElement>) {
        
        self.sectionElements = sectionElements
        self.sectionElements.forEach { (sectionElement: ALSectionElement) in
            sectionElement.delegate = self
        }
        self.tableView?.reloadData()
    }
}

//MARK: - Private methods

extension ALTableView {
    
    public func getSectionElementAt(index: Int) -> ALSectionElement? {
        return self.sectionElements[ALSafe: index]
    }
    
    public func getNumberOfSections() -> Int {
        return self.sectionElements.count
    }
    
    public func getNumberOfRowsAt(section: Int) -> Int? {
        return self.getSectionElementAt(index: section)?.getNumberOfRealRows()
    }
    
    private func getIndexSections(position: ALPosition, numberOfSectionElements: Int, operation: ALOperation) -> IndexSet {
        
        let indexOperator: ALIndexOperator = operation.getIndexOperator(position: position, numberOfElements: numberOfSectionElements)
        let section: Int = indexOperator.calculateIndex()

        let lowerIndex: Int = section
        let higherIndex: Int = section + numberOfSectionElements
        let indexSet: IndexSet = IndexSet(integersIn: lowerIndex..<higherIndex)
        return indexSet
    }
    
}
