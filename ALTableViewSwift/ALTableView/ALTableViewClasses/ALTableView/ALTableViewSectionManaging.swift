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
    
    public func insert(sectionElements: Array<ALSectionElement>, section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        guard let indexSection = self.getIndexSections(section: section, numberOfSectionElements: sectionElements.count) else {
            return false
        }
        self.sectionManager.insert(sectionElements: sectionElements, section: section)
        self.tableView?.beginUpdates()
        self.tableView?.insertSections(indexSection, with: animation)
        self.tableView?.endUpdates()
        return true
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
        
        return self.insert(sectionElement: sectionElement, section: ALPosition.begining.rawValue)
    }
    
    public func insert(sectionElements: Array<ALSectionElement>, atTheBeginingOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: sectionElements, section: ALPosition.begining.rawValue)
    }
    
    public func insert(sectionElement: ALSectionElement, atTheEndOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(sectionElement: sectionElement, section: ALPosition.end.rawValue)
    }
    
    public func insert(sectionElements: Array<ALSectionElement>, atTheEndOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(sectionElements: sectionElements, section: ALPosition.end.rawValue)
    }
}

//MARK: - Managing the removal of new sections

extension ALTableView {
    
    public func remove(sectionElements: Array<ALSectionElement>, section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        guard let indexSection = self.getIndexSections(section: section, numberOfSectionElements: sectionElements.count) else {
            return false
        }
        self.sectionManager.delete(numberOfSectionElements: sectionElements.count, section: section)
        self.tableView?.beginUpdates()
        self.tableView?.deleteSections(indexSection, with: animation)
        self.tableView?.endUpdates()
        return true
    }
    
    public func remove(sectionElement: ALSectionElement, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(sectionElement: sectionElement, section: ALPosition.begining.rawValue)
    }
    
    public func remove(sectionElement: ALSectionElement, section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(sectionElements: [sectionElement], section: section, animation: animation)
    }
    
    public func remove(sectionElements: Array<ALSectionElement>, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(sectionElements: sectionElements, section: indexPath.section, animation: animation)
    }
    
    public func remove(sectionElement: ALSectionElement, atTheBeginingOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(sectionElement: sectionElement, section: ALPosition.begining.rawValue)
    }
    
    public func remove(sectionElements: Array<ALSectionElement>, atTheBeginingOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(sectionElements: sectionElements, section: ALPosition.begining.rawValue)
    }
    
    public func remove(sectionElement: ALSectionElement, atTheEndOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(sectionElement: sectionElement, section: ALPosition.end.rawValue)
    }
    
    public func remove(sectionElements: Array<ALSectionElement>, atTheEndOfTableView section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(sectionElements: sectionElements, section: ALPosition.end.rawValue)
    }
}

//MARK: - Managing the replacement of new sections

extension ALTableView {
    
    public func replace(sectionElements: Array<ALSectionElement>, section: Int, row: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        guard let indexSection = self.getIndexSections(section: section, numberOfSectionElements: sectionElements.count) else {
            return false
        }
        self.sectionManager.replace(sectionElements: sectionElements, section: section)
        self.tableView?.beginUpdates()
        self.tableView?.reloadSections(indexSection, with: animation)
        self.tableView?.endUpdates()
        return true
    }
    
    public func replace(sectionElement: ALSectionElement, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.replace(sectionElement: sectionElement, section: indexPath.section, row: indexPath.row, animation: animation)
    }
    
    public func replace(sectionElement: ALSectionElement, section: Int, row: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.replace(sectionElements: [sectionElement], section: section, row: row, animation: animation)
        
    }
    
    public func replace(sectionElements: Array<ALSectionElement>, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.replace(sectionElements: sectionElements, section: indexPath.section, row: indexPath.row, animation: animation)
    }
    
    public func replaceAllSections(sectionElements: Array<ALSectionElement>) {
        
        self.sectionManager.replaceAllSections(sectionElements: sectionElements)
        self.tableView?.reloadData()
    }
}

//MARK: - Private methods

extension ALTableView {
    
    private func getIndexSections(section: Int, numberOfSectionElements: Int) -> IndexSet? {
        
        if !self.checkParameters(section: section, row: nil) {
            return nil
        }
        
        var mutableSection = section
        switch mutableSection {
        case ALPosition.begining.rawValue:
            mutableSection = 0
        case ALPosition.end.rawValue:
            mutableSection = self.sectionManager.getNumberOfSections()
        default:
            break
        }
        let lowerIndex: Int = mutableSection
        let higherIndex: Int = mutableSection + numberOfSectionElements
        let indexSet: IndexSet = IndexSet(integersIn: lowerIndex..<higherIndex)
        return indexSet
    }
}
