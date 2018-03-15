//
//  ALRowElementTests.swift
//  ALTableViewTests
//
//  Created by lorenzo villarroel perez on 14/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import XCTest
@testable import ALTableView




class ALRowElementTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDefaultConstructor() {
        let cellIdentifier = "MasterTableViewCell"
        let tableView = UITableView()
        let alTableView = ALTableView(sectionElements: [], viewController: UIViewController(), tableView: tableView)
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
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
