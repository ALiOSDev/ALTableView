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

class ALRowElement: ALElement, ALRowElementProtocol  {
    
    //MARK: - Properties
    

    private var className: AnyClass //TODO es posible que el className no sea necesario

    private let cellStyle: UITableViewCellStyle
    
    private var pressedHandler: ALCellPressedHandler?
    private var createdHandler: ALCellCreatedHandler?
    private var deselectedHandler: ALCellDeselectedHandler?
    
    //MARK: - Initializers
    
    init(className: AnyClass, identifier: String, dataObject: Any, cellStyle: UITableViewCellStyle = .default, estimateHeightMode: Bool = false, height: CGFloat = 44.0, pressedHandler: ALCellPressedHandler? = nil, createdHandler: ALCellCreatedHandler? = nil, deselectedHandler: ALCellDeselectedHandler? = nil) {
        
        self.className = className
//        self.identifier = identifier
//        self.dataObject = dataObject
        self.cellStyle = cellStyle
//        self.estimateHeightMode = estimateHeightMode
//        self.height = height
        self.pressedHandler = pressedHandler
        self.createdHandler = createdHandler
        self.deselectedHandler = deselectedHandler
        super.init(identifier: identifier, dataObject: dataObject, estimateHeightMode: estimateHeightMode, height: height)
    }

    //MARK: - Getters
    
    internal func getDataObject() -> Any {
        
        return self.dataObject
    }
    
    internal func getCellHeight() -> CGFloat {
        
        return self.height
    }
    
    internal func isEstimateHeightMode() -> Bool {
        
        return self.estimateHeightMode
    }
    
    //MARK: - Setters
    
    internal func setCellHeight(height: CGFloat) -> Void {
        
        self.height = height
    }
    
    internal func getCellFrom(tableView: UITableView) -> UITableViewCell {
        
        if let dequeuedCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.identifier)  {
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































