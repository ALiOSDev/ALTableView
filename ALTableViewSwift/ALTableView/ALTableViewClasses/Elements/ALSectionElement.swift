//
//  SectionElement.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 7/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

//Implemented by ALSectionManager
protocol ALSectionHeaderViewDelegate: class {
    func sectionOpened(sectionElement: ALSectionElement)
    func sectionClosed(sectionElement: ALSectionElement)
}

class ALSectionElement {

    //MARK: - Properties
    
    private let headerElement: ALHeaderFooterElement?
    private let footerElement: ALHeaderFooterElement?
    
    private var isOpened: Bool = true
    private let isExpandable: Bool
    
    private var headerTapGesture: UITapGestureRecognizer?
    private var rowElements: Array<ALRowElement>
    
    internal weak var delegate: ALSectionHeaderViewDelegate?
    
    //MARK: - Initializers
    
    init(rowElements: Array<ALRowElement>, headerElement: ALHeaderFooterElement?, footerElement: ALHeaderFooterElement?, headerHeight: CGFloat = 0, footerHeight: CGFloat = 0, isExpandable: Bool = false) {
        
        self.headerElement = headerElement
        self.footerElement = footerElement
        self.isExpandable = isExpandable
        self.rowElements = rowElements
    }
    
    //MARK: - Getters
    
    internal func getHeaderFrom(tableView: UITableView) -> UIView? {
        guard let viewHeader = self.headerElement?.getViewFrom(tableView: tableView) else {
            return nil
        }
        self.setUpHeaderRecognizer(viewHeader: viewHeader)
        return viewHeader
    }
    
    internal func getFooterFrom(tableView: UITableView) -> UIView? {
        
        return self.footerElement?.getViewFrom(tableView: tableView)
    }
    
    internal func getNumberOfRows() -> Int {
        
        if self.isOpened {
            return self.rowElements.count
        } else {
            return 0
        }
    }
    
    internal func getNumberOfRealRows() -> Int {
        
        return self.rowElements.count
    }
    
    internal func getRowElementAt(position: Int) -> ALRowElement? {
        
        let rowElement: ALRowElement? = self.rowElements[ALSafe: position]
        return rowElement
    }
    
    internal func getRowEstimatedHeight(at position: Int) -> CGFloat {
        
        return self.getRowElementAt(position: position)?.getEstimatedHeight() ?? 0.0
    }
    
    internal func getHeaderEstimatedHeight() -> CGFloat {
        
        return self.headerElement?.getEstimatedHeight() ?? 0.0
    }
    
    internal func getFooterEstimatedHeight() -> CGFloat {
        
        return self.footerElement?.getEstimatedHeight() ?? 0.0
    }
    
    internal func getRowHeight(at position: Int) -> CGFloat {
        
        return self.getRowElementAt(position: position)?.getHeight() ?? 0.0
    }
    
    internal func getHeaderHeight() -> CGFloat {
        
        return self.headerElement?.getHeight() ?? 0.0
    }
    
    internal func getFooterHeight() -> CGFloat {
        
        return self.footerElement?.getHeight() ?? 0.0
    }
    
    internal func getHeaderElement() -> ALHeaderFooterElement? {
        
        return self.headerElement
    }
    
    internal func getFooterElement() -> ALHeaderFooterElement? {
        
        return self.footerElement
    }
    
//    internal func getSectionTitleIndex() -> String {
//        return self.sectionTitleIndex
//    }
    
    //MARK: - Managing the insertion of new cells
    
    internal func insert(rowElements: Array<ALRowElement>, at index: Int) -> Bool {
        
        self.rowElements.insert(contentsOf: rowElements, at: index)
        return true
    }
    
    //MARK: - Managing the deletion of new cells

    internal func deleteRowElements(numberOfRowElements: Int, at index: Int) -> Bool {
        
        let endIndex: Int = index + numberOfRowElements
        guard self.rowElements.indices.contains(endIndex) else {
            return false
        }
        self.rowElements.removeSubrange(index...endIndex)
        return true
    }
    
    //MARK: - Managing the replacement of new cells
    
    internal func replace(rowElements: Array<ALRowElement>, at index: Int) -> Bool {
        
        guard self.deleteRowElements(numberOfRowElements: rowElements.count, at: index),
        self.insert(rowElements: rowElements, at: index) else {
            return false
        }
        return true
    }
    
    //MARK: - Managing the opening and close of section
    
    private func setUpHeaderRecognizer (viewHeader: UIView) -> Void {
        
        if self.headerTapGesture == nil {
            self.headerTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.toggleOpen(sender:)))
            if let headerTapGesture = self.headerTapGesture {
                viewHeader.isUserInteractionEnabled = true
                viewHeader.addGestureRecognizer(headerTapGesture)
            }
        }
    }
    
    @objc private func toggleOpen(sender: Any) {
        
        if self.isExpandable {
            self.toggleOpenWith(userAction: true)
        }
    }
    
    private func toggleOpenWith(userAction: Bool) {
        
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

//MARK: - Equatable

extension ALSectionElement: Equatable {
    
    static func ==(lhs: ALSectionElement, rhs: ALSectionElement) -> Bool {
        
        return lhs === rhs
    }
}
































