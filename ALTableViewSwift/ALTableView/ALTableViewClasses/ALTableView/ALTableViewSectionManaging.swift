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
    
    private func insert(sectionElements: Array<ALSectionElement>, position: ALPosition, animation: UITableViewRowAnimation = .top) -> Bool {
        
        guard self.sectionManager.insert(sectionElements: sectionElements, position: position) else {
            return false
        }
        let indexSection = self.getIndexSections(position: position, numberOfSectionElements: sectionElements.count, operation: .replace)
        self.tableView?.beginUpdates()
        self.tableView?.insertSections(indexSection, with: animation)
        self.tableView?.endUpdates()
        return true
    }
    
    private func insert(sectionElement: ALSectionElement, position: ALPosition, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: [sectionElement], position: position, animation: animation)
    }
    
    public func insert(sectionElements: Array<ALSectionElement>, section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: sectionElements, position: .middle(section), animation: animation)
    }
    
    public func insert(sectionElement: ALSectionElement, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(sectionElement: sectionElement, section: indexPath.section, animation: animation)
    }
    
    public func insert(sectionElement: ALSectionElement, section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: [sectionElement], section: section, animation: animation)
    }
    
    public func insert(sectionElements: Array<ALSectionElement>, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: sectionElements, section: indexPath.section, animation: animation)
    }
    
    public func insert(sectionElement: ALSectionElement, atTheBeginingOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(sectionElement: sectionElement, position: .begining)
    }
    
    public func insert(sectionElements: Array<ALSectionElement>, atTheBeginingOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: sectionElements, position: .begining)
    }
    
    public func insert(sectionElement: ALSectionElement, atTheEndOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(sectionElement: sectionElement, position: .end)
    }
    
    public func insert(sectionElements: Array<ALSectionElement>, atTheEndOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: sectionElements, position: .end)
    }
}

//MARK: - Managing the removal of new sections

extension ALTableView {
    
    private func remove(sectionElements: Array<ALSectionElement>, position: ALPosition, animation: UITableViewRowAnimation = .top) -> Bool {
        
        guard self.sectionManager.delete(numberOfSectionElements: sectionElements.count, position: position) else {
            return false
        }
        let indexSection = self.getIndexSections(position: position, numberOfSectionElements: sectionElements.count, operation: .replace)
        self.tableView?.beginUpdates()
        self.tableView?.deleteSections(indexSection, with: animation)
        self.tableView?.endUpdates()
        return true
    }
    
    private func remove(sectionElement: ALSectionElement, position: ALPosition, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: [sectionElement], position: position, animation: animation)
    }
    
    public func remove(sectionElements: Array<ALSectionElement>, section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        return self.remove(sectionElements: sectionElements, position: .middle(section), animation: animation)
    }
    
    public func remove(sectionElement: ALSectionElement, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(sectionElement: sectionElement, section: indexPath.section)
    }
    
    public func remove(sectionElement: ALSectionElement, section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(sectionElements: [sectionElement], section: section, animation: animation)
    }
    
    public func remove(sectionElements: Array<ALSectionElement>, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(sectionElements: sectionElements, section: indexPath.section, animation: animation)
    }
    
    public func remove(sectionElement: ALSectionElement, atTheBeginingOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(sectionElement: sectionElement, position: .begining)
    }
    
    public func remove(sectionElements: Array<ALSectionElement>, atTheBeginingOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(sectionElements: sectionElements, position: .begining)
    }
    
    public func remove(sectionElement: ALSectionElement, atTheEndOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(sectionElement: sectionElement, position: .end)
    }
    
    public func remove(sectionElements: Array<ALSectionElement>, atTheEndOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(sectionElements: sectionElements, position: .end)
    }
}

//MARK: - Managing the replacement of new sections

extension ALTableView {
    
    public func replace(sectionElements: Array<ALSectionElement>, position: ALPosition, animation: UITableViewRowAnimation = .top) -> Bool {
        
        guard self.sectionManager.replace(sectionElements: sectionElements, position: position) else {
            return false
        }
        let indexSection = self.getIndexSections(position: position, numberOfSectionElements: sectionElements.count, operation: .replace)
        self.tableView?.beginUpdates()
        self.tableView?.reloadSections(indexSection, with: animation)
        self.tableView?.endUpdates()
        return true
    }
    
    public func replace(sectionElement: ALSectionElement, position: ALPosition, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.replace(sectionElements: [sectionElement], position: position, animation: animation)
    }
    
    public func replace(sectionElements: Array<ALSectionElement>, section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.replace(sectionElements: sectionElements, position: .middle(section), animation: animation)
    }
    
    public func replace(sectionElement: ALSectionElement, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.replace(sectionElement: sectionElement, section: indexPath.section, animation: animation)
    }
    
    public func replace(sectionElement: ALSectionElement, section: Int,  animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.replace(sectionElements: [sectionElement], section: section, animation: animation)
        
    }
    
    public func replace(sectionElements: Array<ALSectionElement>, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.replace(sectionElements: sectionElements, section: indexPath.section, animation: animation)
    }
    
    public func replaceAllSections(sectionElements: Array<ALSectionElement>) {
        
        self.sectionManager.replaceAllSections(sectionElements: sectionElements)
        self.tableView?.reloadData()
    }
}

//MARK: - Private methods

extension ALTableView {
    
    private func getIndexSections(position: ALPosition, numberOfSectionElements: Int, operation: ALOperation) -> IndexSet {
        
        let indexOperator: ALIndexOperator = operation.getIndexOperator(position: position, numberOfElements: numberOfSectionElements)
        let section: Int = indexOperator.calculateIndex()

        let lowerIndex: Int = section
        let higherIndex: Int = section + numberOfSectionElements
        let indexSet: IndexSet = IndexSet(integersIn: lowerIndex..<higherIndex)
        return indexSet
    }
    
}
