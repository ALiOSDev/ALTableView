//
//  ALSectionElementHeader.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 26/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

extension ALSectionElement {
    
    //MARK: - Getters
    
    internal func getHeaderFrom(tableView: UITableView) -> UIView? {
        
        guard let viewHeader = self.headerElement?.getViewFrom(tableView: tableView) else {
            return nil
        }
        self.setUpHeaderRecognizer(viewHeader: viewHeader)
        return viewHeader
    }
    
    internal func getHeaderElement() -> ALHeaderFooterElement? {
        
        return self.headerElement
    }
    
    internal func getHeaderHeight() -> CGFloat {
        
        return self.headerElement?.getHeight() ?? 0.0
    }
    
    internal func getHeaderEstimatedHeight() -> CGFloat {
        
        return self.headerElement?.getEstimatedHeight() ?? 0.0
    }
    
}

//MARK: - Managing the opening and close of section

extension ALSectionElement {
    
    fileprivate func setUpHeaderRecognizer (viewHeader: UIView) -> Void {
        if let headerTapGesture = self.headerTapGesture {
            viewHeader.removeGestureRecognizer(headerTapGesture)
            self.headerTapGesture = nil
        }
        if self.headerTapGesture == nil {
            self.headerTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.toggleOpen(sender:)))
            if let headerTapGesture = self.headerTapGesture {
                viewHeader.isUserInteractionEnabled = true
                viewHeader.addGestureRecognizer(headerTapGesture)
            }
        }
    }
    
    @objc func toggleOpen(sender: Any) {
        
        if self.isExpandable {
            self.toggleOpenWith(userAction: true)
        }
    }
    
    func toggleOpenWith(userAction: Bool) {
        
        guard let delegate = self.delegate else {
            return
        }
        self.isOpened = !self.isOpened
        if userAction {
            if self.isOpened {
                delegate.sectionOpened(sectionElement: self)
            } else {
                delegate.sectionClosed(sectionElement: self)
            }
        }
    }
    
}
