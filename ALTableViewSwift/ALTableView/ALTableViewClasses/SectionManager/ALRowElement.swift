//
//  RowElement.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 7/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

class ALRowElement {
    
    //MARK: - Properties
    
    private var estimateHeightMode: Bool
    private var cellHeight: Int
    private let className: AnyClass
    private let cellIdentifier: String
    private let dataObject: Any
    private let cellStyle: UITableViewCellStyle
    
    //MARK: - Initializers
    
    init(className: AnyClass, cellIdentifier: String, dataObject: Any, cellStyle: UITableViewCellStyle = .default, estimateHeightMode: Bool = false, cellHeight: Int = 0) {
        
        self.className = className
        self.cellIdentifier = cellIdentifier
        self.dataObject = dataObject
        self.cellStyle = cellStyle
        self.estimateHeightMode = estimateHeightMode
        self.cellHeight = cellHeight
    }

}
