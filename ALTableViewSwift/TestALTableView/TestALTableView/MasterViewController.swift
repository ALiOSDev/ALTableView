//
//  MasterViewController.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 7/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit
import ALTableView

class MasterViewController: UITableViewController, ALTableViewProtocol {
    
    var detailViewController: DetailViewController? = nil
    var alTableView: ALTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        self.tableView.tableFooterView = UIView()
        
        
        let sectionElements = self.createElements()
        
        self.alTableView = ALTableView(sectionElements: sectionElements, viewController: self, tableView: self.tableView)
        self.alTableView?.delegate = self
        self.registerCells()
        self.tableView.reloadData()
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.alTableView?.addPullToRefresh(title: NSAttributedString(string: "Refreshing..."), backgroundColor: .green, tintColor: .blue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let object = objects[indexPath.row] as! NSDate
//                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
//                controller.detailItem = object
//                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
        }
    }
    
    func createElements() -> [ALSectionElement] {
        var sectionElements = [ALSectionElement]()
        for _ in 0...4 {
            var rowElements = Array<ALRowElement>()
            let rowElement = ALRowElement(className:MasterTableViewCell.classForCoder(), identifier: MasterTableViewCell.reuseIdentifier, dataObject: "Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1", estimateHeightMode: true)
            let rowElement2 = ALRowElement(className:Master2TableViewCell.classForCoder(), identifier: Master2TableViewCell.reuseIdentifier, dataObject: 12, estimateHeightMode: true)
            rowElements.append(rowElement)
            rowElements.append(rowElement2)
            
            let headerElement = ALHeaderFooterElement(identifier: MasterHeaderFooter.reuseIdentifier, dataObject: "Header Test", estimateHeightMode: true)
            
            let section = ALSectionElement(rowElements: rowElements, headerElement: headerElement, footerElement: nil, isExpandable: true)
            
            sectionElements.append(section)
        }
        
        return sectionElements
    }
    
    func registerCells() {
        self.alTableView?.registerCell(nibName: MasterTableViewCell.nib, reuseIdentifier: MasterTableViewCell.reuseIdentifier)
        self.alTableView?.registerCell(nibName: Master2TableViewCell.nib, reuseIdentifier: Master2TableViewCell.reuseIdentifier)
        self.alTableView?.registerHeaderFooter(nibName: MasterHeaderFooter.nib, reuseIdentifier: MasterHeaderFooter.reuseIdentifier)
    }
    
    func tableViewPullToRefresh() {
        print("Refreshed")
    }
    
    func tableViewDidReachEnd() {
        print("End Reached")
    }
    
}

