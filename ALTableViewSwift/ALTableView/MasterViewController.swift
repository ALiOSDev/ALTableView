//
//  MasterViewController.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 7/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    let masterTableViewCellString = "MasterTableViewCell"

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var alTableView: ALTableView?
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.registerCells()
        let sectionElements = self.createElements()

        self.alTableView = ALTableView(sectionElements: sectionElements, viewController: self)
        self.tableView.delegate = self.alTableView
        self.tableView.dataSource = self.alTableView
        self.tableView.reloadData()
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
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    func createElements() -> [ALSectionElement] {
        var rowElements = Array<ALRowElement>()
        //        rowElements.append()
        let rowElement = ALRowElement(className:MasterTableViewCell.classForCoder(), cellIdentifier: masterTableViewCellString, dataObject: "Texto 1")
        let rowElement2 = ALRowElement(className:MasterTableViewCell.classForCoder(), cellIdentifier: masterTableViewCellString, dataObject: "Texto 2")
        rowElements.append(rowElement)
        rowElements.append(rowElement2)
        print(rowElements)
        let section = ALSectionElement(rowElements: rowElements )
        var sectionElements = [ALSectionElement]()
        sectionElements.append(section)
        
        return sectionElements
    }

    func registerCells() {
        let nib = UINib(nibName: masterTableViewCellString, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: masterTableViewCellString)
//        self.alTableView?.register(nibName: masterTableViewCellString, reuseIdentifier: masterTableViewCellString, into: self.tableView)
    }


}

