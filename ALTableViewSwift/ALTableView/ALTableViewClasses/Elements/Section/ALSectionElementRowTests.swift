//
//  ALSectionElementRowTests.swift
//  ALTableViewTests
//
//  Created by lorenzo villarroel perez on 26/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import XCTest
@testable import ALTableView

class ALSectionElementRowTests: XCTestCase {
    
    static let cellIdentifier = "CellIdentifier"
    static let baseDataObject = "Cell"
    static let numberOfDefaultRows = 3
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: - Get
    
    //Tests first position
    func testGetSingleElement() {
        self.testGetSingleElement(position: .middle(0))
    }
    
    //Tests intermediate position
    func testGetSingleElement2() {
        self.testGetSingleElement(position: .middle(0))
    }
    
    //Tests last position
    func testGetSingleElement3() {
        self.testGetSingleElement(position: .middle(ALSectionElementRowTests.numberOfDefaultRows - 1))
    }
    
    //Tests first position by enum
    func testGetSingleElementBegining() {
        self.testGetSingleElement(position: .begining)
    }
    
    //Tests last position by enum
    func testGetSingleElementEnd() {
        self.testGetSingleElement(position: .end)
    }
    
    //Tests out of bounds
    func testGetSingleElementOutOfBounds() {
        let sectionElement = self.createSectionElement()
        let index = ALSectionElementRowTests.numberOfDefaultRows + 1
        let rowElement = self.createRowElement(index: index)
        XCTAssertFalse(sectionElement.insert(rowElements: [rowElement], at: .middle(index)), "Row inserted when should not")
        XCTAssert(sectionElement.getNumberOfRows() == 3, "Incorrect number of shown rows")
        XCTAssert(sectionElement.getNumberOfRealRows() == 3, "Incorrect number of real rows")
        
        XCTAssertFalse(sectionElement.insert(rowElements: [rowElement], at: .middle(-1)), "Row inserted when should not")
        XCTAssert(sectionElement.getNumberOfRows() == 3, "Incorrect number of shown rows")
        XCTAssert(sectionElement.getNumberOfRealRows() == 3, "Incorrect number of real rows")
    }
    
    //MARK: - Insertion
    
    //Tests first position
    func testInsertionSingleElement() {
        self.testInsertionSingleElement(position: .middle(0))
    }
    
    //Tests intermediate position
    func testInsertionSingleElement2() {
        self.testInsertionSingleElement(position: .middle(1))
    }
    
    //Tests last position
    func testInsertionSingleElement3() {
        self.testInsertionSingleElement(position: .middle(ALSectionElementRowTests.numberOfDefaultRows))
    }
    
    //Tests first position by enum
    func testInsertionSingleElementBegining() {
        self.testInsertionSingleElement(position: .begining)
    }
    
    //Tests last position by enum
    func testInsertionSingleElementEnd() {
        self.testInsertionSingleElement(position: .end)
    }
    
    //Tests out of bounds
    func testInsertionSingleElementOutOfBounds() {
        let sectionElement = self.createSectionElement()
        let index = ALSectionElementRowTests.numberOfDefaultRows + 1
        let rowElement = self.createRowElement(index: index)
        XCTAssertFalse(sectionElement.insert(rowElements: [rowElement], at: .middle(index)), "Row inserted when should not")
        XCTAssert(sectionElement.getNumberOfRows() == ALSectionElementRowTests.numberOfDefaultRows, "Incorrect number of shown rows")
        XCTAssert(sectionElement.getNumberOfRealRows() == ALSectionElementRowTests.numberOfDefaultRows, "Incorrect number of real rows")
        
        XCTAssertFalse(sectionElement.insert(rowElements: [rowElement], at: .middle(-1)), "Row inserted when should not")
        XCTAssert(sectionElement.getNumberOfRows() == ALSectionElementRowTests.numberOfDefaultRows, "Incorrect number of shown rows")
        XCTAssert(sectionElement.getNumberOfRealRows() == ALSectionElementRowTests.numberOfDefaultRows, "Incorrect number of real rows")
    }
    

    
//    func testRemoval() {
//        let sectionElement = self.createSectionElement()
//    }
//
//    func testReplacement() {
//        let sectionElement = self.createSectionElement()
//    }
//
    
    //MARK: - Support functions
    
    func testGetSingleElement(position: ALPosition) {
        let indexOperator: ALIndexOperator = ALOperation.get.getIndexOperator(position: position, numberOfElements: ALSectionElementRowTests.numberOfDefaultRows)
        let index = indexOperator.calculateIndex()
        let sectionElement = self.createSectionElement()
        
        if let rowElement = sectionElement.getRowElementAt(index: index) {
            if let dataObject = rowElement.getDataObject() as? String {
                let expectedDataObject = self.getDataObject(index: index)
                XCTAssert(dataObject == expectedDataObject, "Incorrect dataObject")
            }
        } else {
            XCTFail("RowElement not found")
        }
        
    }
    
    func testInsertionSingleElement(position: ALPosition, numberOfElementsToInsert: Int = 1) {

        let indexOperator: ALIndexOperator = ALOperation.insert.getIndexOperator(position: position, numberOfElements: ALSectionElementRowTests.numberOfDefaultRows)
        let index = indexOperator.calculateIndex()
        let sectionElement = self.createSectionElement()
//        let index = ALSectionElementRowTests.numberOfDefaultRows
        var rowElements = [ALRowElement]()
        
        for i in index..<index + numberOfElementsToInsert {
            let rowElement = self.createRowElement(index: i + 1000)
            rowElements.append(rowElement)
        }
        
        
        let numberOfElementsAfterInsertion = ALSectionElementRowTests.numberOfDefaultRows + rowElements.count
        
        XCTAssert(sectionElement.insert(rowElements: rowElements, at: position), "Row not inserted")
        XCTAssert(sectionElement.getNumberOfRows() == numberOfElementsAfterInsertion, "Incorrect number of shown rows")
        XCTAssert(sectionElement.getNumberOfRealRows() == numberOfElementsAfterInsertion, "Incorrect number of real rows")
        
        for i in index..<index + numberOfElementsToInsert {
            if let rowElement = sectionElement.getRowElementAt(index: i) {
                if let dataObject = rowElement.getDataObject() as? String {
                    let expectedDataObject = self.getDataObject(index: i + 1000)
                    XCTAssert(dataObject == expectedDataObject, "Incorrect dataObject")
                }
            } else {
                XCTFail("RowElement not found")
            }
        }
        
        
        
    }

    func createSectionElement() -> ALSectionElement {
        var rowElements = Array<ALRowElement>()
        for i in 0..<ALSectionElementRowTests.numberOfDefaultRows {
            
            let rowElement = self.createRowElement(index: i)
            rowElements.append(rowElement)
        }
        
        let sectionElement = ALSectionElement(rowElements: rowElements, headerElement: nil, footerElement: nil, isExpandable: true)
        return sectionElement
    }
    
    func createRowElement(index: Int) -> ALRowElement {
        let dataObject = self.getDataObject(index: index)
        let identifier = ALSectionElementRowTests.cellIdentifier
        let rowElement = ALRowElement(className:MasterTableViewCell.classForCoder(), identifier: identifier, dataObject: dataObject, estimateHeightMode: true)
        return rowElement
    }
    
    func getDataObject(index: Int) -> String {
        return ALSectionElementRowTests.baseDataObject + String(index)
    }
    
}
