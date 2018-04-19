//
//  RowElement.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 7/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

public typealias ALCellPressedHandler = (UIViewController?, UITableViewCell) -> Void
public typealias ALCellCreatedHandler = (Any, UITableViewCell) -> Void
public typealias ALCellDeselectedHandler = (UITableViewCell) -> Void

//Implemented by ALRowElement
public protocol ALRowElementProtocol {
    func rowElementPressed(viewController: UIViewController?, cell: UITableViewCell)
    func rowElementDeselected(cell: UITableViewCell)
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

public class ALRowElement: ALElement, ALRowElementProtocol  {
    
    //MARK: - Properties
    

    private var className: AnyClass //TODO es posible que el className no sea necesario

    private let cellStyle: UITableViewCellStyle
    
    private var pressedHandler: ALCellPressedHandler?
    private var createdHandler: ALCellCreatedHandler?
    private var deselectedHandler: ALCellDeselectedHandler?
    
    //MARK: - Initializers
    
    init(className: AnyClass, identifier: String, dataObject: Any, cellStyle: UITableViewCellStyle = .default, estimateHeightMode: Bool = false, height: CGFloat = 44.0, pressedHandler: ALCellPressedHandler? = nil, createdHandler: ALCellCreatedHandler? = nil, deselectedHandler: ALCellDeselectedHandler? = nil) {
        
        self.className = className
        self.cellStyle = cellStyle
        self.pressedHandler = pressedHandler
        self.createdHandler = createdHandler
        self.deselectedHandler = deselectedHandler
        super.init(identifier: identifier, dataObject: dataObject, estimateHeightMode: estimateHeightMode, height: height)
    }

    //MARK: - Getters
    
    internal func getViewFrom(tableView: UITableView) -> UITableViewCell {
        
        guard let dequeuedElement: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.identifier) else {
            return UITableViewCell()
        }
        if let alCell = dequeuedElement as? ALCellProtocol {
            object_setClass(alCell, self.className)
            alCell.cellCreated(dataObject: self.dataObject)
        }
        if let handler:ALCellCreatedHandler = self.createdHandler {
            handler(self.dataObject, dequeuedElement)
        }
        return dequeuedElement
    }
    
    
    //MARK: - Setters
    
    internal func setCellHeight(height: CGFloat) -> Void {
        
        self.height = height
    }

    //MARK: - ALRowElementProtocol
    
    public func rowElementPressed(viewController: UIViewController?, cell: UITableViewCell) {
        
        if let cell: ALCellProtocol = cell as? ALCellProtocol {
            cell.cellPressed(viewController: viewController)
        }
        
        if let handler:ALCellPressedHandler = self.pressedHandler {
            handler(viewController, cell)
        }
    }
    
    public func rowElementDeselected(cell: UITableViewCell) {
        
        if let cell: ALCellProtocol = cell as? ALCellProtocol {
            cell.cellDeselected()
        }
        
        if let handler: ALCellDeselectedHandler = self.deselectedHandler {
            handler(cell)
        }
    }
}































