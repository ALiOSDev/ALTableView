//
//  SectionElement.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 7/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

protocol ALSectionHeaderViewDelegate {
    func sectionOpened(sectionElement: ALSectionElement)
    func sectionClosed(section: ALSectionElement)
}

class ALSectionElement {
    
    //MARK: - Properties
    
    private let viewHeader: UIView
    private let viewFooter: UIView
    
    private let heightHeader: Int
    private let heightFooter: Int
    
    private let isOpened: Bool = true
    private let isExpandable: Bool
    
    private var headerTapGesture: UITapGestureRecognizer?
    private let rowElements: Array<ALRowElement>
    
    init(viewHeader: UIView = UIView(), viewFooter: UIView = UIView(), heightHeader: Int = 0, heightFooter: Int = 0, isExpandable: Bool = false, rowElements: Array<ALRowElement>) {
        self.viewHeader = viewHeader
        self.viewFooter = viewFooter
        self.heightHeader = heightHeader
        self.heightFooter = heightFooter
        self.isExpandable = isExpandable
        self.rowElements = rowElements
    }
    
}
