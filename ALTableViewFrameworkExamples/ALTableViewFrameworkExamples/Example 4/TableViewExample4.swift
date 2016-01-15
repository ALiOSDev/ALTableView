//
//  File.swift
//  ALTableViewFrameworkExamples
//
//  Created by Abimael Barea Puyana on 5/1/16.
//  Copyright © 2016 Abimael Barea Puyana. All rights reserved.
//

import UIKit

class TableViewExample4 : ALTableViewController {
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        replaceAllSectionElements(createElements())
        
        tableView.tableFooterView = UIView.init()
    }
    
    
    // MARK: - Register Cells
    
    func registerCells() {
        self.registerClass(Example4Cell1.classForCoder(), cellIdentifier: "Example4Cell1")
    }
    
    
    // MARK: - Create Cells
    
    func createElements() -> NSMutableArray {
        let sections = NSMutableArray()
        let rows = NSMutableArray()
        
        let row1 = RowElement.init(className: Example4Cell1.classForCoder(), object: 40, heightCell: 60, cellIdentifier: nil)
        let row2 = RowElement.init(className: UITableViewCell.classForCoder(), object: 40, heightCell: 60, cellIdentifier: nil, cellStyle: UITableViewCellStyle.Subtitle,
            cellPressedHandler: { viewController, cell in
                cell.textLabel!!.text = "Cell selected"
                cell.detailTextLabel!!.text = "adios"
            },
            cellCreatedHandler: { (object, cell) -> Void in
                cell.textLabel!!.text = "My height is: " + object.stringValue
                cell.detailTextLabel!!.text = "Hola"
            },
            cellDeselectedHandler: { (cell) -> Void in
                cell.textLabel!!.text = "Cell deselected"
        })
        
        rows.addObject(row1)
        rows.addObject(row2)
        
        let sectionElement = SectionElement.init(sectionTitleIndex: nil, viewHeader: nil, viewFooter: nil, heightHeader: 0, heightFooter: 0, cellObjects: rows, isExpandable: false)
        sections.addObject(sectionElement)
        
        return sections;
    }
    
}
