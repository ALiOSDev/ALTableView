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
        self.title = "Example 4";
        
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
        var rows = NSMutableArray()
        
        
        // First section ************
        
        rows.addObject(RowElement.init(className: Example4Cell1.classForCoder(), object: 40, heightCell: 60, cellIdentifier: nil))
        
        let row2 = RowElement.init(className: UITableViewCell.classForCoder(), object: 40, heightCell: 60, cellIdentifier: nil, cellStyle: UITableViewCellStyle.Subtitle,
            cellPressedHandler: { viewController, cell in
                cell.textLabel!!.text = "Cell selected"
                cell.detailTextLabel!!.text = "adios"
            },
            cellCreatedHandler: { (object, cell) -> Void in
                cell.textLabel!!.text = "My height is: " + object.stringValue
                cell.detailTextLabel!!.text = "Hola"
            },
            cellDeselectedHandler: { cell in
                cell.textLabel!!.text = "Cell deselected"
        })
        rows.addObject(row2)
        
        let sectionElement = SectionElement.init(sectionTitleIndex: nil, viewHeader: nil, viewFooter: nil, heightHeader: 0, heightFooter: 0, cellObjects: rows, isExpandable: false)
        sections.addObject(sectionElement)
        
        
        // Second section ************
        
        rows = NSMutableArray()
        
        let params : [String : AnyObject] = [
            PARAM_ROWELEMENT_CLASS:Example4Cell1.classForCoder(),
            PARAM_ROWELEMENT_OBJECT:40 as NSNumber,
            PARAM_ROWELEMENT_HEIGHTCELL:60 as NSNumber,
        ]
        rows.addObject(RowElement.init(params: params))
        
        
        let blockCreated : @convention(block) (object: AnyObject, cell: UITableViewCell) -> Void = { object, cell in
            cell.textLabel!.text = "My height is: " + object.stringValue
            cell.detailTextLabel!.text = "Hola"
        }
        
        let blockPressed : @convention(block) (viewController: UIViewController, cell: UITableViewCell) -> Void = { viewController, cell in
            cell.textLabel!.text = "Cell selected"
            cell.detailTextLabel!.text = "adios"
        }
        
        let params2 : [String : AnyObject] = [
            PARAM_ROWELEMENT_CLASS:UITableViewCell.classForCoder(),
            PARAM_ROWELEMENT_OBJECT:40 as NSNumber,
            PARAM_ROWELEMENT_HEIGHTCELL:40 as NSNumber,
            PARAM_ROWELEMENT_CELL_STYLE:UITableViewCellStyle.Subtitle.rawValue as NSNumber,
            PARAM_ROWELEMENT_CELL_CREATED:unsafeBitCast(blockCreated, AnyObject.self),
            PARAM_ROWELEMENT_CELL_PRESSED:unsafeBitCast(blockPressed, AnyObject.self)
        ]
        rows.addObject(RowElement.init(params: params2))
        
        
        let params3 : [String : AnyObject] = [
            PARAM_ROWELEMENT_CLASS:UITableViewCell.classForCoder(),
            PARAM_ROWELEMENT_OBJECT:40 as NSNumber,
            PARAM_ROWELEMENT_HEIGHTCELL:40 as NSNumber,
            PARAM_ROWELEMENT_CELL_STYLE:UITableViewCellStyle.Subtitle.rawValue as NSNumber
        ]
        rows.addObject(RowElement.init(params: params3,
            cellPressedHandler: { viewController, cell in
                cell.textLabel!!.text = "Cell selected"
                cell.detailTextLabel!!.text = "adios"
            },
            cellCreatedHandler: { (object, cell) -> Void in
                cell.textLabel!!.text = "My height is: " + object.stringValue
                cell.detailTextLabel!!.text = "Hola"
            },
            cellDeselectedHandler: { cell in
                cell.textLabel!!.text = "Cell deselected"
        }))
        
        
        let labelTitle = UILabel.init(frame: CGRectMake(0, 0, view.frame.size.width, 40))
        labelTitle.text = "Section 2 Header"
        labelTitle.backgroundColor = UIColor.blueColor()
        
        let paramsSection : [String : AnyObject] = [
            PARAM_SECTIONELEMENT_VIEW_HEADER:labelTitle,
            PARAM_SECTIONELEMENT_HEIGHT_HEADER:40 as NSNumber,
            PARAM_SECTIONELEMENT_CELL_OBJECTS:rows,
            PARAM_SECTIONELEMENT_IS_EXPANDABLE:true as NSNumber
        ]
        sections.addObject(SectionElement.init(params: paramsSection))
        
        return sections;
    }
    
}
