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
    func cellCreated(dataObject: AnyObject) -> Void
}

class ALRowElement<DataObjectType: AnyObject, CellClass: UITableViewCell>: ALRowElementProtocol  {
    
    //MARK: - Properties
    
    private var estimateHeightMode: Bool
    private var cellHeight: Double
    private var className: AnyClass //TODO es posible que el className no sea necesario
    private let cellIdentifier: String
    private let dataObject: DataObjectType
    private let cellStyle: UITableViewCellStyle
    
    private var pressedHandler: ALCellPressedHandler?
    private var createdHandler: ALCellCreatedHandler?
    private var deselectedHandler: ALCellDeselectedHandler?
    
    //MARK: - Initializers
    
    init(className: AnyClass, cellIdentifier: String, dataObject: DataObjectType, cellStyle: UITableViewCellStyle = .default, estimateHeightMode: Bool = false, cellHeight: Double = 0.0, pressedHandler: ALCellPressedHandler? = nil, createdHandler: ALCellCreatedHandler? = nil, deselectedHandler: ALCellDeselectedHandler? = nil) {
        
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
    
    public func getDataObject() -> DataObjectType {
        
        return self.dataObject
    }
    
    public func getCellHeight() -> Double {
        
        return self.cellHeight
    }
    
    public func getCellFrom(tableView: UITableView) -> UITableViewCell {
        
        if let dequeuedCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) {
            return dequeuedCell
        } else {
            let cell: UITableViewCell = CellClass(style: self.cellStyle, reuseIdentifier: self.cellIdentifier)
            object_setClass(cell, self.className)
            cell.cellCreated(dataObject: self.dataObject)
            if let handler:ALCellCreatedHandler = self.createdHandler {
                handler(self.dataObject, cell)
            }
            return cell
        }
    }
    
    //MARK: - Handlers
    
    func rowElementPressed(viewController: UIViewController, cell: ALCellProtocol) {
        
        cell.cellPressed(viewController: viewController)
        if let handler:ALCellPressedHandler = self.pressedHandler {
            handler(viewController, cell)
        }
    }
    
    func rowElementDeselected(cell: ALCellProtocol) {
        
        cell.cellDeselected()
        if let handler: ALCellDeselectedHandler = self.deselectedHandler {
            handler(cell)
        }
    }
}































