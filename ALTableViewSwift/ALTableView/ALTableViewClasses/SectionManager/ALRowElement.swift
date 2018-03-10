//
//  RowElement.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 7/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

public typealias ALCellPressedHandler = (UIViewController?, ALCellProtocol) -> Void
public typealias ALCellCreatedHandler = (Any, ALCellProtocol) -> Void
public typealias ALCellDeselectedHandler = (ALCellProtocol) -> Void

//Implemented by ALRowElement
protocol ALRowElementProtocol {
    func rowElementPressed(viewController: UIViewController?, cell: ALCellProtocol)
    func rowElementDeselected(cell: ALCellProtocol)
}

//Implemented by UITableViewCell
public protocol ALCellProtocol {
    func cellPressed (viewController: UIViewController?) -> Void
    func cellDeselected () -> Void
    func cellCreated(dataObject: Any) -> Void
}

extension ALCellProtocol {
    public func cellPressed (viewController: UIViewController?) -> Void {
        
    }
    
    public func cellDeselected () -> Void {
        
    }
    
    public func cellCreated(dataObject: Any) -> Void {
        print("ALCellProtocol")
    }
}

class ALRowElement: ALRowElementProtocol  {
    
    //MARK: - Properties
    
    private var estimateHeightMode: Bool
    private var cellHeight: CGFloat
    private var className: AnyClass //TODO es posible que el className no sea necesario
    private let cellIdentifier: String
    private let dataObject: Any
    private let cellStyle: UITableViewCellStyle
    
    private var pressedHandler: ALCellPressedHandler?
    private var createdHandler: ALCellCreatedHandler?
    private var deselectedHandler: ALCellDeselectedHandler?
    
    //MARK: - Initializers
    
        init(className: AnyClass, cellIdentifier: String, dataObject: Any, cellStyle: UITableViewCellStyle = .default, estimateHeightMode: Bool = false, cellHeight: CGFloat = 44.0, pressedHandler: ALCellPressedHandler? = nil, createdHandler: ALCellCreatedHandler? = nil, deselectedHandler: ALCellDeselectedHandler? = nil) {
    
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
    
    internal func getDataObject() -> Any {
        
        return self.dataObject
    }
    
    internal func getCellHeight() -> CGFloat {
        
        return self.cellHeight
    }
    
    internal func isEstimateHeightMode() -> Bool {
        
        return self.estimateHeightMode
    }
    
    //MARK: - Setters
    
    internal func setCellHeight(height: CGFloat) -> Void {
        
        self.cellHeight = height
    }
    
    internal func getCellFrom(tableView: UITableView) -> UITableViewCell {
        
        if let dequeuedCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier)  {
            if let alCell = dequeuedCell as? ALCellProtocol {
                object_setClass(alCell, self.className)
                alCell.cellCreated(dataObject: self.dataObject)
                if let handler:ALCellCreatedHandler = self.createdHandler {
                    handler(self.dataObject, alCell)
                }
            }
            return dequeuedCell
        }
        return UITableViewCell()
    }
    
    //MARK: - ALRowElementProtocol
    
    func rowElementPressed(viewController: UIViewController?, cell: ALCellProtocol) {
        
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































