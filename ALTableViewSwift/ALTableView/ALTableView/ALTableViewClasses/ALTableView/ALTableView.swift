//
//  ALTableView.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 7/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

@objc public protocol ALTableViewProtocol: class {
    @objc optional func tableViewPullToRefresh()
    @objc optional func tableViewDidReachEnd()
}

public class ALTableView: NSObject {

    //MARK: - Properties
    
    internal var sectionElements: Array<ALSectionElement>
    public weak var delegate: ALTableViewProtocol?
    public weak var editingDelegate: ALTableViewRowEditingProtocol?
    public weak var viewController: UIViewController?
    public weak var tableView: UITableView?
    public var editingAllowed: Bool
    public var movingRowsAllowed: Bool
    
    
    //MARK: - Initializers
    
    public init(sectionElements: Array<ALSectionElement>,
                viewController: UIViewController,
                tableView: UITableView,
                editingAllowed: Bool = false,
                movingRowsAllowed: Bool = false) {
        
        self.sectionElements = sectionElements
        self.editingAllowed = editingAllowed
        self.movingRowsAllowed = movingRowsAllowed
        super.init()
        self.viewController = viewController
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView = tableView
        self.sectionElements.forEach { (sectionElement: ALSectionElement) in
            sectionElement.delegate = self
        }
      
    }
    
    //MARK: - Public methods
    
    public func registerCell(nibName: String, reuseIdentifier: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.tableView?.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    public func registerHeaderFooter(nibName: String, reuseIdentifier: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.tableView?.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    //MARK: - Private methods
    

}
















