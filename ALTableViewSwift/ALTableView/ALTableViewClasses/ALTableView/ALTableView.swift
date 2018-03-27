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
    case begining = -1000
    case end = -1001
}

//enum ALPosition {
//    case begining
//    case end(Array<Any>)
//
//    func indexInsert() -> Int {
//        switch self {
//        case .begining:
//            return 0
//        case .end(let array):
//            return array.count
//
//        }
//    }
//
//    func index() -> Int {
//        switch self {
//        case .begining:
//            return 0
//        case .end(let array):
//            return array.count - 1
//
//        }
//    }
//}



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
    
    public func registerCell(nibName: String, reuseIdentifier: String) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        self.tableView?.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    public func registerHeaderFooter(nibName: String, reuseIdentifier: String) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        self.tableView?.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    //MARK: - Private methods
    

}















