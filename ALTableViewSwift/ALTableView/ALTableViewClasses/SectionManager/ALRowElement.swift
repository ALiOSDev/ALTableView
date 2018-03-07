//
//  RowElement.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 7/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

public typealias ALCellPressedHandler = (UIViewController, ALCellProtocol) -> Void
public typealias ALCellCreatedHandler = (AnyObject, ALCellProtocol) -> Void
public typealias ALCellDeselectedHandler = (ALCellProtocol) -> Void

protocol ALRowElementProtocol {
    func rowElementPressed(viewController: UIViewController, cell: ALCellProtocol)
    func rowElementDeselected(cell: ALCellProtocol)
}

public protocol ALCellProtocol: class {
    func cellPressed (viewController: UIViewController) -> Void
    func cellDeselected () -> Void
}

class ALRowElement<T>: ALRowElementProtocol  {
    
    //MARK: - Properties
    
    private var estimateHeightMode: Bool
    private var cellHeight: Double
    private let className: AnyClass
    private let cellIdentifier: String
    private let dataObject: T
    private let cellStyle: UITableViewCellStyle
    
    private var pressedHandler: ALCellPressedHandler?
    private var createdHandler: ALCellCreatedHandler?
    private var deselectedHandler: ALCellDeselectedHandler?
    
    //MARK: - Initializers
    
    init(className: AnyClass, cellIdentifier: String, dataObject: T, cellStyle: UITableViewCellStyle = .default, estimateHeightMode: Bool = false, cellHeight: Double = 0.0, pressedHandler: ALCellPressedHandler? = nil, createdHandler: ALCellCreatedHandler? = nil, deselectedHandler: ALCellDeselectedHandler? = nil) {
        
        self.className = className
        self.cellIdentifier = cellIdentifier
        self.dataObject = dataObject
        self.cellStyle = cellStyle
        self.estimateHeightMode = estimateHeightMode
        self.cellHeight = cellHeight
        self.pressedHandler = pressedHandler
        self.createdHandler = createdHandler
        self.deselectedHandler = deselectedHandler
    }

    //MARK: - Getters
    
    public func getDataObject() -> T {
        
        return self.dataObject
    }
    
    public func getCellHeight() -> Double {
        
        return self.cellHeight
    }
    
    //MARK: - Handlers
    
    func rowElementPressed(viewController: UIViewController, cell: ALCellProtocol) {
        cell.cellPressed(viewController: viewController)
        if let handler = self.pressedHandler {
            handler(viewController, cell)
        }
    }
    
    func rowElementDeselected(cell: ALCellProtocol) {
        cell.cellDeselected()
        if let handler = self.deselectedHandler {
            handler(cell)
        }
    }
}































