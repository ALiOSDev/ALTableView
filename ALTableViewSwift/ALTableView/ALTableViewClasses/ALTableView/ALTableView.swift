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

class ALTableView: NSObject {

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
    
    internal func checkParameters(section: Int, row: Int?) -> Bool {
        
        //TODO Test section and row conditions
        guard section < self.sectionManager.getNumberOfSections()  else {
            print("Attempting to insert in a non-existing section")
            return false
        }
        
        guard let row: Int = row,
            row < self.sectionManager.getNumberOfRows(in: section) else {
                print("Attempting to insert in a non-existing row")
                return false
        }
        
        return true
    }
    


}















