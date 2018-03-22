//
//  ALTableViewRowManaging.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 16/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

//MARK: - Managing the insertion of new cells

extension ALTableView {
    
    public func insert(rowElements: Array<ALRowElement>, section: Int, row: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        guard self.sectionManager.insert(rowElements: rowElements, section: section, row: row) else {
            return false
        }
        let indexPathes = self.getIndexPathes(section: section, row: row, numberOfRowElements: rowElements.count)
        self.tableView?.beginUpdates()
        self.tableView?.insertRows(at: indexPathes, with: animation)
        self.tableView?.endUpdates()
        return true
    }
    
    public func insert(rowElement: ALRowElement, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(rowElement: rowElement, section: indexPath.section, row: indexPath.row, animation: animation)
    }
    
    public func insert(rowElement: ALRowElement, section: Int, row: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(rowElements: [rowElement], section: section, row: row, animation: animation)
    }
    
    public func insert(rowElements: Array<ALRowElement>, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(rowElements: rowElements, section: indexPath.section, row: indexPath.row, animation: animation)
    }
    
    public func insert(rowElement: ALRowElement, atTheBeginingOfSection section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(rowElement: rowElement, section: section, row: ALPosition.begining.rawValue)
    }
    
    public func insert(rowElements: Array<ALRowElement>, atTheBeginingOfSection section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(rowElements: rowElements, section: section, row: ALPosition.begining.rawValue)
    }
    
    public func insert(rowElement: ALRowElement, atTheEndOfSection section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(rowElement: rowElement, section: section, row: ALPosition.end.rawValue)
    }
    
    public func insert(rowElements: Array<ALRowElement>, atTheEndOfSection section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(rowElements: rowElements, section: section, row: ALPosition.end.rawValue)
    }
}

//MARK: - Managing the removal of new cells

extension ALTableView {
    
    public func remove(rowElements: Array<ALRowElement>, section: Int, row: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        guard self.sectionManager.delete(numberOfRowElements: rowElements.count, section: section, row: row) else {
            return false
        }
        let indexPathes = self.getIndexPathes(section: section, row: row, numberOfRowElements: rowElements.count)
        self.tableView?.beginUpdates()
        self.tableView?.deleteRows(at: indexPathes, with: animation)
        self.tableView?.endUpdates()
        return true
    }
    
    public func remove(rowElement: ALRowElement, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(rowElement: rowElement, section: indexPath.section, row: indexPath.row, animation: animation)
    }
    
    public func remove(rowElement: ALRowElement, section: Int, row: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(rowElements: [rowElement], section: section, row: row, animation: animation)
    }
    
    public func remove(rowElements: Array<ALRowElement>, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(rowElements: rowElements, section: indexPath.section, row: indexPath.row, animation: animation)
    }
    
    public func remove(rowElement: ALRowElement, atTheBeginingOfSection section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(rowElement: rowElement, section: section, row: ALPosition.begining.rawValue)
    }
    
    public func remove(rowElements: Array<ALRowElement>, atTheBeginingOfSection section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(rowElements: rowElements, section: section, row: ALPosition.begining.rawValue)
    }
    
    public func remove(rowElement: ALRowElement, atTheEndOfSection section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(rowElement: rowElement, section: section, row: ALPosition.end.rawValue)
    }
    
    public func remove(rowElements: Array<ALRowElement>, atTheEndOfSection section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.remove(rowElements: rowElements, section: section, row: ALPosition.end.rawValue)
    }
}

//MARK: - Managing the replacement of new cells

extension ALTableView {
    
    public func replace(rowElements: Array<ALRowElement>, section: Int, row: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        guard self.sectionManager.replace(rowElements: rowElements, section: section, row: row) else {
            return false
        }
        let indexPathes = self.getIndexPathes(section: section, row: row, numberOfRowElements: rowElements.count)
        self.tableView?.beginUpdates()
        self.tableView?.reloadRows(at: indexPathes, with: animation)
        self.tableView?.endUpdates()
        return true
    }
    
    public func replace(rowElement: ALRowElement, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.replace(rowElement: rowElement, section: indexPath.section, row: indexPath.row, animation: animation)
    }
    
    public func replace(rowElement: ALRowElement, section: Int, row: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.replace(rowElements: [rowElement], section: section, row: row, animation: animation)
        
    }
    
    public func replace(rowElements: Array<ALRowElement>, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.replace(rowElements: rowElements, section: indexPath.section, row: indexPath.row, animation: animation)
    }
}

//MARK: - Private methods

extension ALTableView {
    
    private func getIndexPathes(section: Int, row: Int, numberOfRowElements: Int) -> Array<IndexPath>{
        
        var mutableRow = row
        switch mutableRow {
        case ALPosition.begining.rawValue:
            mutableRow = 0
        case ALPosition.end.rawValue:
            mutableRow = self.sectionManager.getNumberOfRows(in: section)
        default:
            break
        }
        
        var indexPathes: Array<IndexPath> = [IndexPath]()
        for i in 0..<numberOfRowElements {
            let indexPath: IndexPath = IndexPath(row: i + mutableRow, section: section)
            indexPathes.append(indexPath)
        }
        
        return indexPathes
    }
}

//MARK: - ALSectionManagerProtocol

extension ALTableView: ALSectionManagerProtocol {
    
    func sectionOpened(at section: Int, numberOfElements: Int) {
        
        let indexPathes = self.getIndexPathes(section: section, row: 0, numberOfRowElements: numberOfElements)
        self.tableView?.beginUpdates()
        self.tableView?.insertRows(at: indexPathes, with: .top)
        self.tableView?.endUpdates()
    }
    
    func sectionClosed(at section: Int, numberOfElements: Int) {
        
        let indexPathes = self.getIndexPathes(section: section, row: 0, numberOfRowElements: numberOfElements)
        self.tableView?.beginUpdates()
        self.tableView?.deleteRows(at: indexPathes, with: .top)
        self.tableView?.endUpdates()
    }
}