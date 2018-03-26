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
    
    internal let headerElement: ALHeaderFooterElement?
    internal let footerElement: ALHeaderFooterElement?
    
    internal var isOpened: Bool = true
    internal let isExpandable: Bool
    
    internal var headerTapGesture: UITapGestureRecognizer?
    internal var rowElements: Array<ALRowElement>
    
    internal weak var delegate: ALSectionHeaderViewDelegate?
    
    //MARK: - Initializers
    
    init(rowElements: Array<ALRowElement>, headerElement: ALHeaderFooterElement?, footerElement: ALHeaderFooterElement?, headerHeight: CGFloat = 0, footerHeight: CGFloat = 0, isExpandable: Bool = false) {
        
        self.headerElement = headerElement
        self.footerElement = footerElement
        self.isExpandable = isExpandable
        self.rowElements = rowElements
    }
    
    //MARK: - Getters

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
    

    

    

    

    

    


    

    

    
//    internal func getSectionTitleIndex() -> String {
//        return self.sectionTitleIndex
//    }
    

    

}

//MARK: - Equatable

extension ALSectionElement: Equatable {
    
    static func ==(lhs: ALSectionElement, rhs: ALSectionElement) -> Bool {
        
        return lhs === rhs
    }
}
































