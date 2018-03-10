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
    
    private let viewHeader: UIView
    private let viewFooter: UIView
    
    private let headerHeight: CGFloat
    private let footerHeight: CGFloat
    
    private var isOpened: Bool = true
    private let isExpandable: Bool
    
//    private var headerTapGesture: UITapGestureRecognizer?
    private var rowElements: Array<ALRowElement>
    
    internal weak var delegate: ALSectionHeaderViewDelegate?
    
    //MARK: - Initializers
    
    init(viewHeader: UIView = UIView(), viewFooter: UIView = UIView(), headerHeight: CGFloat = 0, footerHeight: CGFloat = 0, isExpandable: Bool = false, rowElements: Array<ALRowElement>) {
        self.viewHeader = viewHeader
        self.viewFooter = viewFooter
        self.headerHeight = headerHeight
        self.footerHeight = footerHeight
        self.isExpandable = isExpandable
        self.rowElements = rowElements
        self.setUpHeaderRecognizer()
    }
    
    
    //MARK: - Getters
    
    internal func getHeader() -> UIView {
        
        return self.viewHeader
    }
    
    internal func getFooter() -> UIView {
        
        return self.viewFooter
    }
    
    internal func getHeaderHeight() -> CGFloat {
        
        return self.headerHeight
    }

    internal func getFooterHeight() -> CGFloat {
        
        return self.footerHeight
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
        
        guard position >= 0 && position < self.rowElements.count else {
            return nil
        }
        let rowElement: ALRowElement = self.rowElements[position]
        return rowElement
    }
    
    internal func getRowHeight(at position: Int) -> CGFloat? {
        
        if let rowElement = self.getRowElementAt(position: position) {
            return rowElement.getCellHeight()
        }
        return nil
    }
    
//    internal func getSectionTitleIndex() -> String {
//        return self.sectionTitleIndex
//    }
    
    //MARK: - Managing the insertion of new cells

    internal func insert(rowElement: ALRowElement, at index: Int) -> Void {
        
        self.rowElements.insert(rowElement, at: index)
    }
    
    internal func insert(rowElements: Array<ALRowElement>, at index: Int) -> Void {
        
        self.rowElements.insert(contentsOf: rowElements, at: index)
    }
    
    //MARK: - Managing the deletion of new cells
    internal func deleteRowElement(at index: Int) -> Void {
        
        self.rowElements.remove(at: index)
    }

    internal func deleteRowElements(numberOfRowElements: Int, at index: Int) -> Void {
        
        let endIndex: Int = index + numberOfRowElements
        self.rowElements.removeSubrange(index...endIndex)
    }
    
    //MARK: - Managing the replacement of new cells
    internal func replaceRowElement(at index: Int, withRowElement rowElement: ALRowElement) {
        
        self.rowElements.remove(at: index)
        self.rowElements.insert(rowElement, at: index)
    }
    
    //MARK: - Managing the opening and close of section
    
    private func setUpHeaderRecognizer () -> Void {
        
        self.viewHeader.isUserInteractionEnabled = true
        let headerTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.toggleOpen(sender:)))
        self.viewHeader.addGestureRecognizer(headerTapGesture)
    }
    
    @objc private func toggleOpen(sender: Any) {
        
        if self.isExpandable {
            self.toggleOpenWith(userAction: true)
        }
    }
    
    private func toggleOpenWith(userAction: Bool) {
        
        if let delegate = self.delegate {
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
}

//MARK: - Equatable

extension ALSectionElement: Equatable {
    
    static func ==(lhs: ALSectionElement, rhs: ALSectionElement) -> Bool {
        
        return lhs === rhs
    }
}
































