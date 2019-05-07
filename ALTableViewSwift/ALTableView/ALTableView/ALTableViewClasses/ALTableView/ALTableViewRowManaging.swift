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
    
    private func insert(rowElements: Array<ALRowElement>, section: Int, position: ALPosition, animation: UITableView.RowAnimation = .top) -> Bool {
        
        guard let sectionElement: ALSectionElement = self.getSectionElementAt(index: section),
            sectionElement.insert(rowElements: rowElements, at: position) else {
                return false
        }

        let indexPathes = self.getIndexPathes(section: section, position: position, numberOfRowElements: rowElements.count, operation: .insert)
        self.tableView?.beginUpdates()
        self.tableView?.insertRows(at: indexPathes, with: animation)
        self.tableView?.endUpdates()
        return true
    }
    
    private func insert(rowElement: ALRowElement, section: Int, position: ALPosition, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(rowElements: [rowElement], section: section, position: position, animation: animation)
    }
    
    @discardableResult public func insert(rowElements: Array<ALRowElement>, section: Int, row: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(rowElements: rowElements, section: section, position: .middle(row), animation: animation)
    }
    
    @discardableResult public func insert(rowElement: ALRowElement, at indexPath: IndexPath, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(rowElement: rowElement, section: indexPath.section, row: indexPath.row, animation: animation)
    }
    
    @discardableResult public func insert(rowElement: ALRowElement, section: Int, row: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(rowElements: [rowElement], section: section, row: row, animation: animation)
    }
    
    @discardableResult public func insert(rowElements: Array<ALRowElement>, at indexPath: IndexPath, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(rowElements: rowElements, section: indexPath.section, row: indexPath.row, animation: animation)
    }
    
    @discardableResult public func insert(rowElement: ALRowElement, atTheBeginingOfSection section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(rowElement: rowElement, section: section, position: .begining, animation: animation)
    }
    
    @discardableResult public func insert(rowElements: Array<ALRowElement>, atTheBeginingOfSection section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(rowElements: rowElements, section: section, position: .begining, animation: animation)
    }
    
    @discardableResult public func insert(rowElement: ALRowElement, atTheEndOfSection section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(rowElement: rowElement, section: section, position: .end, animation: animation)
    }
    
    @discardableResult public func insert(rowElements: Array<ALRowElement>, atTheEndOfSection section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.insert(rowElements: rowElements, section: section, position: .end, animation: animation)
    }
}

//MARK: - Managing the removal of new cells

extension ALTableView {
    
    private func remove(rowElements: Int, section: Int, position: ALPosition, animation: UITableView.RowAnimation = .top) -> Bool {
        
        guard let sectionElement: ALSectionElement = self.getSectionElementAt(index: section),
            sectionElement.deleteRowElements(numberOfRowElements: rowElements, at: position) else {
                return false
        }
        let indexPathes = self.getIndexPathes(section: section, position: position, numberOfRowElements: rowElements, operation: .delete)
        self.tableView?.beginUpdates()
        self.tableView?.deleteRows(at: indexPathes, with: animation)
        self.tableView?.endUpdates()
        return true
    }
    
    private func remove(section: Int, position: ALPosition, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(rowElements: 1, section: section, position: position, animation: animation)
    }
    
    @discardableResult public func remove(rowElements: Int, section: Int, row: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(rowElements: rowElements, section: section, position: .middle(row), animation: animation)
    }
    
    @discardableResult public func remove(at indexPath: IndexPath, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(section: indexPath.section, row: indexPath.row, animation: animation)
    }
    
    @discardableResult public func remove( section: Int, row: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(rowElements: 1, section: section, row: row, animation: animation)
    }
    
    @discardableResult public func remove(rowElements: Int, at indexPath: IndexPath, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(rowElements: rowElements, section: indexPath.section, row: indexPath.row, animation: animation)
    }
    
    @discardableResult public func remove(atTheBeginingOfSection section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(section: section, position: .begining, animation: animation)
    }
    
    @discardableResult public func remove(rowElements: Int, atTheBeginingOfSection section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(rowElements: rowElements, section: section, position: .begining, animation: animation)
    }
    
    @discardableResult public func remove(atTheEndOfSection section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(section: section, position: .end, animation: animation)
    }
    
    @discardableResult public func remove(rowElements: Int, atTheEndOfSection section: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.remove(rowElements: rowElements, section: section, position: .end, animation: animation)
    }
}

//MARK: - Managing the replacement of new cells

extension ALTableView {
    
    private func replace(rowElements: Array<ALRowElement>, section: Int, position: ALPosition, animation: UITableView.RowAnimation = .top) -> Bool {
        
        guard let sectionElement: ALSectionElement = self.getSectionElementAt(index: section),
            sectionElement.replace(rowElements: rowElements, at: position) else {
                return false
        }
        let indexPathes = self.getIndexPathes(section: section, position: position, numberOfRowElements: rowElements.count, operation: .replace)
        self.tableView?.beginUpdates()
        self.tableView?.reloadRows(at: indexPathes, with: animation)
        self.tableView?.endUpdates()
        return true
    }
    
    private func replace(rowElement: ALRowElement, section: Int, position: ALPosition, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.replace(rowElements: [rowElement], section: section, position: position, animation: animation)
    }
    
    @discardableResult public func replace(rowElements: Array<ALRowElement>, section: Int, row: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.replace(rowElements: rowElements, section: section, position: .middle(row), animation: animation)
    }
    
    @discardableResult public func replace(rowElement: ALRowElement, at indexPath: IndexPath, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.replace(rowElement: rowElement, section: indexPath.section, row: indexPath.row, animation: animation)
    }
    
    @discardableResult public func replace(rowElement: ALRowElement, section: Int, row: Int, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.replace(rowElements: [rowElement], section: section, row: row, animation: animation)
        
    }
    
    @discardableResult public func replace(rowElements: Array<ALRowElement>, at indexPath: IndexPath, animation: UITableView.RowAnimation = .top) -> Bool {
        
        return self.replace(rowElements: rowElements, section: indexPath.section, row: indexPath.row, animation: animation)
    }
}

//MARK: - Private methods

extension ALTableView {
    
    private func getIndexPathes(section: Int, position: ALPosition, numberOfRowElements: Int, operation: ALOperation) -> Array<IndexPath>{
        
        let numberOfElements: Int = self.getSectionElementAt(index: section)?.getNumberOfRows() ?? 0
        let indexOperator: ALIndexOperator = operation.getIndexOperator(position: position, numberOfElements: numberOfElements)
        let row: Int = indexOperator.calculateIndex()
        
        var indexPathes: Array<IndexPath> = [IndexPath]()
        for i in 0..<numberOfRowElements {
            let indexPath: IndexPath = IndexPath(row: i + row, section: section)
            indexPathes.append(indexPath)
        }
        
        return indexPathes
    }
    
}

//MARK: - ALSectionHeaderViewDelegate

extension ALTableView: ALSectionHeaderViewDelegate {
    
    public func openSection(section: Int) {
        guard let section = getSectionElementAt(index: section), !section.isOpened else {
            return
        }
        section.toggleOpen(sender: self)
    }
    
    public func closeSection(section: Int) {
        guard let section = getSectionElementAt(index: section), section.isOpened else {
            return
        }
        section.toggleOpen(sender: self)
    }
    
    func sectionOpened(sectionElement: ALSectionElement) {
        
        guard let section: Int = sectionElements.index(of: sectionElement) else {
            return
        }
        let numberOfElements: Int = sectionElement.getNumberOfRealRows()
        let indexPathes = self.getIndexPathes(section: section, position: .begining, numberOfRowElements: numberOfElements, operation: .insert)
        self.tableView?.beginUpdates()
        self.tableView?.insertRows(at: indexPathes, with: .top)
        self.tableView?.endUpdates()
    }
    
    func sectionClosed(sectionElement: ALSectionElement) {
        
        guard let section: Int = sectionElements.index(of: sectionElement) else {
            return
        }
        let numberOfElements: Int = sectionElement.getNumberOfRealRows()
        let indexPathes = self.getIndexPathes(section: section, position: .begining, numberOfRowElements: numberOfElements, operation: .delete)
        self.tableView?.beginUpdates()
        self.tableView?.deleteRows(at: indexPathes, with: .top)
        self.tableView?.endUpdates()
    }
}

