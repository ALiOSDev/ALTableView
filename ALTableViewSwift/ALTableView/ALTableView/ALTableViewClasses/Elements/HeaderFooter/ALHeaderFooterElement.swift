//
//  ALHeaderFooterElement.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 20/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

public typealias ALHeaderFooterPressedHandler = (UITableViewHeaderFooterView) -> Void
public typealias ALHeaderFooterCreatedHandler = (Any, UITableViewHeaderFooterView) -> Void
public typealias ALHeaderFooterDeselectedHandler = (UITableViewHeaderFooterView) -> Void

//Implemented by ALHeaderFooterElement
public protocol ALHeaderFooterElementProtocol {
    func headerFooterElementPressed(view: UITableViewHeaderFooterView)
}

//Implemented by UITableViewCell
public protocol ALHeaderFooterProtocol {
    func viewPressed () -> Void
    func viewCreated(dataObject: Any) -> Void
}

extension ALHeaderFooterProtocol {
    public func viewPressed () -> Void {
        
    }
    
    public func viewCreated(dataObject: Any) -> Void {
        print("ALHeaderFooterProtocol")
    }
}

public class ALHeaderFooterElement: ALElement, ALHeaderFooterElementProtocol {

    private var pressedHandler: ALHeaderFooterPressedHandler?
    private var createdHandler: ALHeaderFooterCreatedHandler?
    
    //MARK: - Initializers
    
    public init(identifier: String, dataObject: Any, estimateHeightMode: Bool = false, height: CGFloat = 44.0, pressedHandler: ALHeaderFooterPressedHandler? = nil, createdHandler: ALHeaderFooterCreatedHandler? = nil) {
        
        self.pressedHandler = pressedHandler
        self.createdHandler = createdHandler
        super.init(identifier: identifier, dataObject: dataObject, estimateHeightMode: estimateHeightMode, height: height)
    }
    
    //MARK: - Getters
    
    internal func getViewFrom(tableView: UITableView) -> UITableViewHeaderFooterView {
        
        guard let dequeuedElement: UITableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.identifier) else {
            return UITableViewHeaderFooterView()
        }
        if let alHeaderFooter = dequeuedElement as? ALHeaderFooterProtocol {
            alHeaderFooter.viewCreated(dataObject: self.dataObject)
        }
        if let handler:ALHeaderFooterCreatedHandler = self.createdHandler {
            handler(self.dataObject, dequeuedElement)
        }
        return dequeuedElement
    }
    
    //MARK: - ALHeaderFooterElementProtocol
    
    public func headerFooterElementPressed(view: UITableViewHeaderFooterView) {
        
        if let view: ALHeaderFooterProtocol = view as?  ALHeaderFooterProtocol {
            view.viewPressed()
        }
        
        if let handler:ALHeaderFooterPressedHandler = self.pressedHandler {
            handler(view)
        }
    }
}











