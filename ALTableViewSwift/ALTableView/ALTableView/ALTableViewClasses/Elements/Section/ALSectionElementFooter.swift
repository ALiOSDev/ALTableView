//
//  ALSectionElementFooter.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 26/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

extension ALSectionElement {
    
    //MARK: - Getters
    
    internal func getFooterFrom(tableView: UITableView) -> UIView? {
        
        return self.footerElement?.getViewFrom(tableView: tableView)
    }
    
    internal func getFooterElement() -> ALHeaderFooterElement? {
        
        return self.footerElement
    }
    
    internal func getFooterHeight() -> CGFloat {
        
        return self.footerElement?.getHeight() ?? 0.0
    }
    
    internal func getFooterEstimatedHeight() -> CGFloat {
        
        return self.footerElement?.getEstimatedHeight() ?? 0.0
    }
    
    
}
