//
//  ALSectionManagerHeaders.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 26/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

extension ALSectionManager {
    
    //MARK: - Getter Header
    
    internal func getHeaderFrom(tableView: UITableView, section: Int) -> UIView? {
        
        return self.sectionElements[ALSafe: section]?.getHeaderFrom(tableView: tableView)
    }
    
    
    //MARK: - Get Header Elements
    
    internal func getHeaderElementAtIndexPath(indexPath: IndexPath) -> ALHeaderFooterElement? {
        
        return self.getHeaderElementAtSection(section: indexPath.section)
    }
    
    internal func getHeaderElementAtSection(section: Int) -> ALHeaderFooterElement? {
        
        let headerElement: ALHeaderFooterElement? = self.sectionElements[ALSafe: section]?.getHeaderElement()
        return headerElement
    }
    
    //MARK: - Sections Header height
    
    internal func getHeaderHeightFrom(indexPath: IndexPath) -> CGFloat {
        
        return self.getHeaderHeightFrom(section: indexPath.section)
    }
    
    internal func getHeaderHeightFrom(section: Int) -> CGFloat {
        
        guard let sectionElement: ALSectionElement = self.sectionElements[ALSafe: section] else {
            return 0
        }
        return sectionElement.getHeaderHeight()
    }
    
    internal func getHeaderEstimatedHeightFrom(indexPath: IndexPath) -> CGFloat {
        
        return self.getHeaderEstimatedHeightFrom(section: indexPath.section)
    }
    
    internal func getHeaderEstimatedHeightFrom(section: Int) -> CGFloat {
        
        return self.sectionElements[ALSafe: section]?.getHeaderEstimatedHeight() ?? 0.0
    }
    
}
