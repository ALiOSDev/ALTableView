//
//  ALRowElementInizialization.swift
//  ALTableViewTests
//
//  Created by lorenzo villarroel perez on 16/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import XCTest
@testable import ALTableView

class ALRowElementInitialization: XCTestCase {
    
    private let cellIdentifier = "MasterTableViewCell"
    private var tableView: UITableView!
    private var viewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        self.tableView = UITableView()
        self.viewController = UIViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.tableView = nil
        self.viewController = nil
    }
    
    func testDefaultConstructor() {
        let alTableView = ALTableView(sectionElements: [], viewController: viewController, tableView: tableView)
        alTableView.register(nibName: cellIdentifier, reuseIdentifier: cellIdentifier)
        
        let dataObject = "Test"
        let rowElement: ALRowElement = ALRowElement(className: MasterTableViewCell.classForCoder(), cellIdentifier: cellIdentifier, dataObject: dataObject)
        if let rowDataObject = rowElement.getDataObject() as? String {
            XCTAssert(rowDataObject == dataObject, "Data Object does not match the passed one")
        } else {
            XCTFail("Data Object class does not match the passed one")
        }
        
        XCTAssert(rowElement.getCellHeight() == 44, "The height is not the default one")
        
        if let cell = rowElement.getCellFrom(tableView: tableView) as? MasterTableViewCell {
            if let cellText = cell.labelText.text {
                XCTAssert(cellText == dataObject, "Cell text does not match the passed one")
            }
        } else {
            XCTFail("Cell class does not match the passed one")
        }
    }
    
    func testCustomConstructor() {
        let cellHeight: CGFloat = 50.0
        let estimateHeightMode = true
        let alTableView = ALTableView(sectionElements: [], viewController: viewController, tableView: tableView)
        alTableView.register(nibName: cellIdentifier, reuseIdentifier: cellIdentifier)
        
        let dataObject = "Test"
        let labelTextPressed = "Pressed"
        let labelTextDeselected = "Deselected"
        let rowElement: ALRowElement = ALRowElement(className: MasterTableViewCell.classForCoder(), cellIdentifier: cellIdentifier, dataObject: dataObject, cellStyle: .default, estimateHeightMode: estimateHeightMode, cellHeight: cellHeight, pressedHandler: { (viewController, cell) in
            if let masterCell = cell as? MasterTableViewCell {
                masterCell.labelText.text = labelTextPressed
            } else {
                XCTFail("Cell incorrect")
            }
        }, createdHandler: { (object, cell) in
            if let masterCell = cell as? MasterTableViewCell {
                if let string = object as? String {
                    XCTAssert(string == dataObject, "Data Object does not match the passed one")
                    masterCell.labelText.text = string
                } else {
                    XCTFail("Data Object Incorrect")
                }
            } else {
                XCTFail("Cell incorrect")
            }
        }, deselectedHandler: { (cell) in
            if let masterCell = cell as? MasterTableViewCell {
                masterCell.labelText.text = labelTextDeselected
            } else {
                XCTFail("Cell incorrect")
            }
        })

        if let rowDataObject = rowElement.getDataObject() as? String {
            XCTAssert(rowDataObject == dataObject, "Data Object does not match the passed one")
        } else {
            XCTFail("Data Object class does not match the passed one")
        }
        
        XCTAssert(rowElement.getCellHeight() == cellHeight, "The height is not the default one")
        XCTAssert(rowElement.isEstimateHeightMode() == estimateHeightMode, "The estimate mode does not match the passed one")
        
        if let cell = rowElement.getCellFrom(tableView: tableView) as? MasterTableViewCell {
            if let cellText = cell.labelText.text {
                XCTAssert(cellText == dataObject, "Cell text does not match the passed one")
            }
            rowElement.rowElementPressed(viewController: viewController, cell: cell)
            if let cellText = cell.labelText.text {
                XCTAssert(cellText == labelTextPressed, "Cell text does not match the passed one")
            }
            rowElement.rowElementDeselected(cell: cell)
            if let cellText = cell.labelText.text {
                XCTAssert(cellText == labelTextDeselected, "Cell text does not match the passed one")
            }
        } else {
            XCTFail("Cell class does not match the passed one")
        }
    }
    
}
