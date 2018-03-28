//
//  ALArrayExtensionTests.swift
//  ALTableViewTests
//
//  Created by lorenzo villarroel perez on 27/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import XCTest
@testable import ALTableView

class ALArrayExtensionTests: XCTestCase {
    var array: [Int]!
    
    override func setUp() {
        super.setUp()
        self.array = [0,1,2,3,4]
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetSingleElement() {
        for i in 0..<self.array.count {
            if let dataObject = self.array[ALSafe: i] {
                XCTAssert(dataObject == i, "Value at index is incorrect")
            } else {
                XCTFail("Could not retrieve object when should had to")
            }
        }
        
        if let dataObject = self.array[ALSafePosition: ALPosition.end] {
            XCTAssert(dataObject == 4, "Value at index is incorrect")
        } else {
            XCTFail("Could not retrieve object when should had to")
        }
        
        if let dataObject = self.array[ALSafePosition: ALPosition.begining] {
            XCTAssert(dataObject == 0, "Value at index is incorrect")
        } else {
            XCTFail("Could not retrieve object when should had to")
        }
    }
    
    func testGetSingleElementOutOfBounds() {
        if let _ = self.array[ALSafe: -1] {
            XCTFail("Retrieved object when it should not have to")
        }
        if let _ = self.array[ALSafe: self.array.count] {
            XCTFail("Retrieved object when it should not have to")
        }
    }
    
    func testInsertCollection1() {
        
        let collection = [5,6,7]
        self.insertCollection(collection: collection, baseCollection: self.array, index: 0)
    }
    
    func testInsertCollection2() {
        
        let collection = [5,6,7]
        self.insertCollection(collection: collection, baseCollection: self.array, index: self.array.count)
    }
    
    func testInsertCollection3() {
        
        let collection = [5,6,7]
        self.insertCollection(collection: collection, baseCollection: self.array, index: 1)
    }
    
    func testInsertCollection4() {
        
        let collection = [5,6,7]
        self.insertCollection(collection: collection, baseCollection: self.array, position: .begining)
    }
    
    func testInsertCollection5() {
        
        let collection = [5,6,7]
        self.insertCollection(collection: collection, baseCollection: self.array, position: .end)
    }
    
    func testInsertCollection6() {
        
        let collection = [5,6,7]
        self.insertCollection(collection: collection, baseCollection: self.array, position: .middle(1))
    }
    
    func testInsertCollectionOutOfBounds() {
        
        let expectedCapacity = self.array.count
        let collection = [5,6,7]
        if self.array.safeInsert(contentsOf: collection, at: -1) {
            XCTFail("Inserted collection when it should not have to")
        }
        XCTAssertTrue(self.array.count == expectedCapacity, "It does not contain the required number of elements")
        if self.array.safeInsert(contentsOf: collection, at: self.array.count + 1){
            XCTFail("Inserted collection when it should not have to")
        }
        XCTAssertTrue(self.array.count == expectedCapacity, "It does not contain the required number of elements")
    }
    
    func testReplacementCollection1() {
        
        let collection = [5,6]
        self.replaceCollection(collection: collection, baseCollection: self.array, index: 0)
        self.replaceCollection(collection: collection, baseCollection: self.array, position: .begining)
    }
    
    func testReplacementCollection2() {
        
        let collection = [5,6]
        let index = self.array.count - collection.count
        self.replaceCollection(collection: collection, baseCollection: self.array, index: index)
    }
    
    func testReplacementCollection3() {
        
        let collection = [5,6]
        self.replaceCollection(collection: collection, baseCollection: self.array, index: 1)
    }
    
    func testReplacementCollection4() {
        
        let collection = [5,6]
        self.replaceCollection(collection: collection, baseCollection: self.array, position: .begining)
    }
    
    func testReplacementCollection5() {
        
        let collection = [5,6]
        self.replaceCollection(collection: collection, baseCollection: self.array, position: .middle(1))
    }
    
    func testReplacementCollection1OutOfBounds() {
        
        let expectedCapacity = self.array.count
        let collection = [5,6]
        if self.array.safeReplace(contentsOf: collection, at: -1) {
            XCTFail("Inserted collection when it should not have to")
        }
        XCTAssertTrue(self.array.count == expectedCapacity, "It does not contain the required number of elements")
        if self.array.safeReplace(contentsOf: collection, at: self.array.count - 1){
            XCTFail("Inserted collection when it should not have to")
        }
        if self.array.safeReplace(contentsOf: collection, at: self.array.count){
            XCTFail("Inserted collection when it should not have to")
        }
        if self.array.safeReplace(contentsOf: collection, at: .end){
            XCTFail("Inserted collection when it should not have to")
        }
        XCTAssertTrue(self.array.count == expectedCapacity, "It does not contain the required number of elements")
    }
    
    func testDeleteCollection1() {
        self.deleteCollection(numberOfElements: 2, baseCollection: self.array, index: 0)
    }
    
    func testDeleteCollection2() {
        let numberOfElements = 2
        let endIndex = self.array.count - numberOfElements
        self.deleteCollection(numberOfElements: numberOfElements, baseCollection: self.array, index: endIndex)
    }
    
    func testDeleteCollection3() {
        
        self.deleteCollection(numberOfElements: 2, baseCollection: self.array, index: 1)
    }
    
    func testDeleteCollection4() {
        self.deleteCollection(numberOfElements: 2, baseCollection: self.array, position: .begining)
    }
    
    func testDeleteCollection5() {
        
        self.deleteCollection(numberOfElements: 2, baseCollection: self.array, position: .middle(1))
    }
    
    func testDeleteCollection1OutOfBounds() {
        
        let expectedCapacity = self.array.count
        let numberOfElements = 2
        if self.array.safeDelete(numberOfElements: numberOfElements, at: -1) {
            XCTFail("Inserted collection when it should not have to")
        }
        XCTAssertTrue(self.array.count == expectedCapacity, "It does not contain the required number of elements")
        if self.array.safeDelete(numberOfElements: numberOfElements, at: self.array.count - 1) {
            XCTFail("Inserted collection when it should not have to")
        }
        if self.array.safeDelete(numberOfElements: numberOfElements, at: self.array.count) {
            XCTFail("Inserted collection when it should not have to")
        }
        if self.array.safeDelete(numberOfElements: numberOfElements, at: .end) {
            XCTFail("Inserted collection when it should not have to")
        }
        XCTAssertTrue(self.array.count == expectedCapacity, "It does not contain the required number of elements")
    }
    
    
    func insertCollection(collection:[Int], baseCollection: [Int], index: Int) {
        let expectedCapacity = collection.count + baseCollection.count
        var mutablecollection = baseCollection;
        
        XCTAssertTrue(mutablecollection.safeInsert(contentsOf: collection, at: index))
        XCTAssertTrue(mutablecollection.count == expectedCapacity, "It does not contain the required number of elements")
        XCTAssertTrue(mutablecollection.contains(collection), "It must contain the inserted collection")
    }
    
    func insertCollection(collection:[Int], baseCollection: [Int], position: ALPosition) {
        let expectedCapacity = collection.count + baseCollection.count
        var mutablecollection = baseCollection;
        
        XCTAssertTrue(mutablecollection.safeInsert(contentsOf: collection, at: position))
        XCTAssertTrue(mutablecollection.count == expectedCapacity, "It does not contain the required number of elements")
        XCTAssertTrue(mutablecollection.contains(collection), "It must contain the inserted collection")
    }
    
    func replaceCollection(collection:[Int], baseCollection: [Int], index: Int) {
        let expectedCapacity = baseCollection.count
        var mutablecollection = baseCollection;
        
        XCTAssertTrue(mutablecollection.safeReplace(contentsOf: collection, at: index))
        XCTAssertTrue(mutablecollection.count == expectedCapacity, "It does not contain the required number of elements")
        XCTAssertTrue(mutablecollection.contains(collection), "It must contain the inserted collection")
    }
    
    func replaceCollection(collection:[Int], baseCollection: [Int], position: ALPosition) {
        let expectedCapacity = baseCollection.count
        var mutablecollection = baseCollection;
        
        XCTAssertTrue(mutablecollection.safeReplace(contentsOf: collection, at: position))
        XCTAssertTrue(mutablecollection.count == expectedCapacity, "It does not contain the required number of elements")
        XCTAssertTrue(mutablecollection.contains(collection), "It must contain the inserted collection")
    }
    
    func deleteCollection(numberOfElements:Int, baseCollection: [Int], index: Int) {
        let expectedCapacity = baseCollection.count - numberOfElements
        var mutablecollection = baseCollection;
        
        XCTAssertTrue(mutablecollection.safeDelete(numberOfElements: numberOfElements, at: index))
        XCTAssertTrue(mutablecollection.count == expectedCapacity, "It does not contain the required number of elements")
        
    }
    
    func deleteCollection(numberOfElements:Int, baseCollection: [Int], position: ALPosition) {
        let expectedCapacity = baseCollection.count - numberOfElements
        var mutablecollection = baseCollection;
        
        XCTAssertTrue(mutablecollection.safeDelete(numberOfElements: numberOfElements, at: position))
        XCTAssertTrue(mutablecollection.count == expectedCapacity, "It does not contain the required number of elements")
        
    }

    
}
