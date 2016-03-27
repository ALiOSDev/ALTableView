//
//  TableViewExample5.swift
//  ALTableViewFrameworkExamples
//
//  Created by Abimael Barea Puyana on 25/3/16.
//  Copyright © 2016 Abimael Barea Puyana. All rights reserved.
//

import Foundation

class TableViewExample5 : ALTableViewController {
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Example 5";
        
        registerCells()
        replaceAllSectionElements(createElements())
        
        tableView.tableFooterView = UIView.init()
        
        // Add navigation bar button to retrieve cells value
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Get Values", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("handlerSend"))
    }
    
    
    // MARK: - Register Cells
    
    func registerCells() {
        self.registerClass(Example5Cell1.classForCoder(), cellIdentifier: "Example5Cell1")
        self.registerClass(Example5Cell2.classForCoder(), cellIdentifier: "Example5Cell2")
    }
    
    
    // MARK: - Create Cells
    
    func createElements() -> NSMutableArray {
        let sections = NSMutableArray()
        var rows = NSMutableArray()
        
        
        // First section ************
        
        rows.addObject(RowElement.init(className: Example5Cell1.classForCoder(), object: nil, heightCell: 225, cellIdentifier: nil))
        
        let labelTitle1 = UILabel.init(frame: CGRectMake(0, 0, view.frame.size.width, 40))
        labelTitle1.text = "Personal Information"
        labelTitle1.backgroundColor = UIColor.blueColor()
    
        sections.addObject(SectionElement.init(sectionTitleIndex: nil, viewHeader: labelTitle1, viewFooter: nil, heightHeader: 40 as NSNumber, heightFooter: nil, cellObjects: rows, isExpandable: true))
        
        
        // Second section ************
        
        rows = NSMutableArray()
        
        let params : [String : AnyObject] = [
            PARAM_ROWELEMENT_CLASS:Example5Cell2.classForCoder(),
            PARAM_ROWELEMENT_HEIGHTCELL:225 as NSNumber
        ]
        rows.addObject(RowElement.init(params: params))

        let labelTitle2 = UILabel.init(frame: CGRectMake(0, 0, view.frame.size.width, 40))
        labelTitle2.text = "Home"
        labelTitle2.backgroundColor = UIColor.blueColor()
        
        let paramsSection2 : [String : AnyObject] = [
            PARAM_SECTIONELEMENT_VIEW_HEADER:labelTitle2,
            PARAM_SECTIONELEMENT_HEIGHT_HEADER:40 as NSNumber,
            PARAM_SECTIONELEMENT_CELL_OBJECTS:rows,
            PARAM_SECTIONELEMENT_IS_EXPANDABLE:true as NSNumber
        ]
        sections.addObject(SectionElement.init(params: paramsSection2))
        
        return sections;
    }
    
    
    // MARK: - Handler
    
    func handlerSend() {
        var values = ""
        
        for dic in self.retrieveAllElements().values {
            values += dic.description
            print(dic);
        }
        
        let alert = UIAlertController(title: "Values of cells", message: values, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                print("default")
            case .Cancel:
                print("cancel")
            case .Destructive:
                print("destructive")
            }
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
