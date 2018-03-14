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
        self.tableView.tableFooterView = UIView()
        
        
        let sectionElements = self.createElements()

        self.alTableView = ALTableView(sectionElements: sectionElements, viewController: self, tableView: self.tableView)
        self.registerCells()
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
        var sectionElements = [ALSectionElement]()
        for _ in 0...2 {
            var rowElements = Array<ALRowElement>()
            let rowElement = ALRowElement(className:MasterTableViewCell.classForCoder(), cellIdentifier: masterTableViewCellString, dataObject: "Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1Texto 1", estimateHeightMode: true)
            let rowElement2 = ALRowElement(className:MasterTableViewCell.classForCoder(), cellIdentifier: masterTableViewCellString, dataObject: "Texto 2", estimateHeightMode: true)
            rowElements.append(rowElement)
            rowElements.append(rowElement2)
            
            let labelTitle: UILabel = UILabel()
            labelTitle.text = "Header Test"
            labelTitle.backgroundColor = .green
            
            let section = ALSectionElement(rowElements: rowElements, viewHeader: labelTitle, headerHeight: 40, isExpandable: true)
            
            sectionElements.append(section)
        }

        return sectionElements
    }

    func registerCells() {
        self.alTableView?.register(nibName: masterTableViewCellString, reuseIdentifier: masterTableViewCellString)
    }


}

