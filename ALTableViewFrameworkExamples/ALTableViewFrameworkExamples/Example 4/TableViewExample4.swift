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
        tableView.backgroundColor = UIColor.redColor()
    }
    
    
    // MARK: - Register Cells
    
    func registerCells() {
        self.registerClass(Example4Cell1.classForCoder(), cellIdentifier: "Example4Cell1")
        //self.registerClass(Example1Cell2.classForCoder(), cellIdentifier: "Example1Cell2")
    }
    
    
    // MARK: - Create Cells
    
    func createElements() -> NSMutableArray {
        let sections = NSMutableArray()
        let rows = NSMutableArray()

        let row1 = RowElement.init(className: Example4Cell1.classForCoder(), object: 40, heightCell: 60, cellIdentifier: nil)
        //let row2 = RowElement.init(className: Example1Cell2.classForCoder(), object: 60, heightCell: 60, cellIdentifier: nil)

        rows.addObject(row1)
        //rows.addObject(row2)

        let sectionElement = SectionElement.init(sectionTitleIndex: nil, viewHeader: nil, viewFooter: nil, heightHeader: 0, heightFooter: 0, cellObjects: rows, isExpandable: false)
        sections.addObject(sectionElement)
    
        return sections;
    }
    
/*
    
    RowElement * row3 = [[RowElement alloc] initWithClassName:[Example1Cell1 class] object:@80 heightCell:@80 cellIdentifier:nil];
    RowElement * row4 = [[RowElement alloc] initWithClassName:[Example1Cell2 class] object:@100 heightCell:@100 cellIdentifier:nil];
    RowElement * row5 = [[RowElement alloc] initWithClassName:[Example1Cell1 class] object:@120 heightCell:@120 cellIdentifier:nil];
    RowElement * row6 = [[RowElement alloc] initWithClassName:[Example1Cell2 class] object:@140 heightCell:@140 cellIdentifier:nil];
    RowElement * row7 = [[RowElement alloc] initWithClassName:[UITableViewCell class] object:@40 heightCell:@40 cellIdentifier:nil CellStyle:UITableViewCellStyleSubtitle CellPressedHandler:^(UIViewController * viewController, UITableViewCell * cell) {
    cell.textLabel.text = @"Cell selected";
    } CellCreatedHandler:^(NSNumber * object, UITableViewCell * cell)  {
    cell.textLabel.text = [NSString stringWithFormat:@"My height is: %@",[object stringValue]];
    cell.detailTextLabel.text = @"hola";
    } CellDeselectedHandler:^(UITableViewCell * cell) {
    cell.textLabel.text = @"Cell deselected";
    }];
    
}*/

}
