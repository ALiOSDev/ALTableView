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

enum ALPosition: Int {
    case begining = -1
    case end = -2
}

class ALTableView: NSObject, ALSectionManagerProtocol {

    //MARK: - Properties
    
    internal let sectionManager: ALSectionManager
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
    
    //MARK: - Private methods
    
    internal func getIndexPathes(section: Int, row: Int, numberOfRowElements: Int) -> Array<IndexPath>?{
        
        //TODO check this -1
        if !self.checkParameters(section: section, row: row - 1) {
            return nil
        }
        
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
        for i in 0..<row {
            let indexPath: IndexPath = IndexPath(row: i + mutableRow, section: section)
            indexPathes.append(indexPath)
        }
        
        return indexPathes
    }
    
    internal func getIndexSections(section: Int, numberOfSectionElements: Int) -> IndexSet? {
        
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
    
    internal func checkParameters(section: Int, row: Int?) -> Bool {
        
        //TODO Test section and row conditions
        if section > self.sectionManager.getNumberOfSections() {
            print("Attempting to insert in a non-existing section")
            return false
        }
        
        if let row = row {
            if row > self.sectionManager.getNumberOfRows(in: section) {
                print("Attempting to insert in a non-existing row")
                return false
            }
        }
        
        return true
    }
        
    internal func isLastIndexPath (indexPath: IndexPath, tableView: UITableView) -> Bool {
        
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

















