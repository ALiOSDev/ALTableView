//
//  ALTableView.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 7/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

@objc protocol ALTableViewProtocol: class {
    @objc optional func tableViewPullToRefresh()
    @objc optional func tableViewDidReachEnd()
    @objc optional func tableViewWillBeginDragging()
    @objc optional func tableViewWillEndDragging()
}

enum SectionInsert: Int {
    case begining = -1
    case end = -2
}

class ALTableView: NSObject, ALSectionManagerProtocol {

    
    
    //MARK: - Properties
    
    private let sectionManager: ALSectionManager
    public weak var delegate: ALTableViewProtocol?
    public weak var viewController: UIViewController?
    public weak var tableView: UITableView?
    
    //MARK: - Initializers
    
    init(sectionElements: Array<ALSectionElement>, viewController: UIViewController, tableView: UITableView) {
        
        self.sectionManager = ALSectionManager(sectionElements: sectionElements)
        self.viewController = viewController
        self.tableView = tableView
        super.init()
        self.sectionManager.delegate = self
    }
    
    //MARK: - Public methods
    
    public func register(nibName: String, reuseIdentifier: String) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        self.tableView?.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    //MARK: - Managing the insertion of new cells
    
    public func insert(rowElement: ALRowElement, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(rowElement: rowElement, section: indexPath.section, row: indexPath.row, animation: animation)
    }
    
    public func insert(rowElement: ALRowElement, section: Int, row: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        if let indexPathes = self.getIndexPathes(section: section, row: row, numberOfRowElements: 1) {
            self.tableView?.beginUpdates()
            self.tableView?.insertRows(at: indexPathes, with: animation)
            self.tableView?.endUpdates()
            return true
        }
        
        return false
    }
    
    public func insert(rowElements: Array<ALRowElement>, at indexPath: IndexPath, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(rowElements: rowElements, section: indexPath.section, row: indexPath.row, animation: animation)
    }
    
    public func insert(rowElements: Array<ALRowElement>, section: Int, row: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        if let indexPathes = self.getIndexPathes(section: section, row: row, numberOfRowElements: rowElements.count) {
            self.tableView?.beginUpdates()
            self.tableView?.insertRows(at: indexPathes, with: animation)
            self.tableView?.endUpdates()
            return true
        }
        
        return false
    }
    
    public func insert(rowElement: ALRowElement, atTheBeginingOfSection section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(rowElement: rowElement, section: section, row: SectionInsert.begining.rawValue)
    }
    
    public func insert(rowElements: Array<ALRowElement>, atTheBeginingOfSection section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(rowElements: rowElements, section: section, row: SectionInsert.begining.rawValue)
    }
    
    public func insert(rowElement: ALRowElement, atTheEndOfSection section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(rowElement: rowElement, section: section, row: SectionInsert.end.rawValue)
    }
    
    public func insert(rowElements: Array<ALRowElement>, atTheEndOfSection section: Int, animation: UITableViewRowAnimation = .top) -> Bool {
        
        return self.insert(rowElements: rowElements, section: section, row: SectionInsert.end.rawValue)
    }
    
    //MARK: - Private methods
    
    private func getIndexPathes(section: Int, row: Int, numberOfRowElements: Int) -> Array<IndexPath>?{
        
        //TODO check this -1
        if !self.checkParameters(section: section, row: row - 1) {
            return nil
        }
        var mutableRow = row
        switch mutableRow {
        case SectionInsert.begining.rawValue:
            mutableRow = 0
            
        case SectionInsert.end.rawValue:
            mutableRow = self.sectionManager.getNumberOfRows(in: section)
        default:
            break
            
        }
        
        var indexPathes: Array<IndexPath> = [IndexPath]()
        for i in 0..<row {
            let indexPath: IndexPath = IndexPath(row: i + row, section: section)
            indexPathes.append(indexPath)
        }
        
        return indexPathes
    }
    
    private func checkParameters(section: Int, row: Int) -> Bool {
        
        //TODO Test section and row conditions
        if section > self.sectionManager.getNumberOfSections() {
            print("Attempting to insert in a non-existing section")
            return false
        }
        
        if row > self.sectionManager.getNumberOfRows(in: section) {
            print("Attempting to insert in a non-existing row")
            return false
        }
        
        return true
    }
    
    private func isLastIndexPath (indexPath: IndexPath, tableView: UITableView) -> Bool {
        
        let isLastSection: Bool = indexPath.section == tableView.numberOfSections
        let isLastRow: Bool = indexPath.row == tableView.numberOfRows(inSection: indexPath.section)
        return isLastSection && isLastRow
    }
    
    //MARK: - ALSectionManagerProtocol
    
    func sectionOpened(at section: Int, numberOfElements: Int) {
        var indexPathes: Array<IndexPath> = Array<IndexPath>()
        for i in 0..<numberOfElements {
            let indexPath = IndexPath(row: i, section: section)
            indexPathes.append(indexPath)
        }
        self.tableView?.beginUpdates()
        self.tableView?.insertRows(at: indexPathes, with: .top)
        self.tableView?.endUpdates()
    }
    
    func sectionClosed(at section: Int, numberOfElements: Int) {
        var indexPathes: Array<IndexPath> = Array<IndexPath>()
        for i in 0..<numberOfElements {
            let indexPath = IndexPath(row: i, section: section)
            indexPathes.append(indexPath)
        }
        self.tableView?.beginUpdates()
        self.tableView?.deleteRows(at: indexPathes, with: .top)
        self.tableView?.endUpdates()
    }
}

//MARK: - UITableViewDelegate

extension ALTableView: UITableViewDelegate {
    
    //MARK: - Configuring Rows
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if let rowElement: ALRowElement = self.sectionManager.getRowElementAtIndexPath(indexPath: indexPath) {
            if rowElement.isEstimateHeightMode() {
                return UITableViewAutomaticDimension
            } else {
                let estimatedHeight: CGFloat = self.sectionManager.getCellHeightFrom(indexPath: indexPath)
                return estimatedHeight
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let estimatedHeight: CGFloat = self.sectionManager.getCellHeightFrom(indexPath: indexPath)
        return estimatedHeight
    }
    
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //We set up the cellHeight again to avoid stuttering scroll when using automatic dimension with cells
        let cellHeight = cell.frame.size.height
        self.sectionManager.setRowElementHeight(height: cellHeight, indexPath: indexPath)
        
        if self.isLastIndexPath(indexPath: indexPath, tableView: tableView) {
            //We reached the end of the tableView
            self.delegate?.tableViewDidReachEnd?()
        }
    }
    
    //MARK: - Managing selections
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        return indexPath
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell: ALCellProtocol = tableView.cellForRow(at: indexPath) as? ALCellProtocol,
            let rowElement: ALRowElement = self.sectionManager.getRowElementAtIndexPath(indexPath: indexPath) {
            rowElement.rowElementPressed(viewController: self.viewController, cell: cell)
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell: ALCellProtocol = tableView.cellForRow(at: indexPath) as? ALCellProtocol,
            let rowElement: ALRowElement = self.sectionManager.getRowElementAtIndexPath(indexPath: indexPath) {
            rowElement.rowElementDeselected(cell: cell)
        }
    }
    
    //MARK: - Modifying Header and Footer of Sections
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return self.sectionManager.getSectionHeaderAtSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return self.sectionManager.getSectionFooterAtSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return self.sectionManager.getSectionHeaderHeightAtSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return self.sectionManager.getSectionFooterHeightAtSection(section: section)
    }
    
}

//MARK: - UITableViewDataSource

extension ALTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        let numberOfSections: Int = self.sectionManager.getNumberOfSections()
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRows: Int = self.sectionManager.getNumberOfRows(in: section)
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell: UITableViewCell = self.sectionManager.getCellFrom(tableView: tableView, indexPath: indexPath) {
            return cell
        }
        return UITableViewCell()
    }
}


















