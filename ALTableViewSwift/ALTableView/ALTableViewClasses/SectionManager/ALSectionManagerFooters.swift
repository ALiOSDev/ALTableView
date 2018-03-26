//
//  ALSectionManagerFooters.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 26/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

extension ALSectionManager {
    
    //MARK: - Getter Footer
    
    internal func getFooterFrom(tableView: UITableView, section: Int) -> UIView? {
        
        return self.sectionElements[ALSafe: section]?.getFooterFrom(tableView: tableView)
    }
    
    //MARK: - Get Footer Elements
    
    internal func getFooterElementAtIndexPath(indexPath: IndexPath) -> ALHeaderFooterElement? {
        
        return self.getFooterElementAtSection(section: indexPath.section)
    }
    
    internal func getFooterElementAtSection(section: Int) -> ALHeaderFooterElement? {
        
        let footerElement: ALHeaderFooterElement? = self.sectionElements[ALSafe: section]?.getFooterElement()
        return footerElement
    }
    
    //MARK: - Sections Footer height
    
    internal func getFooterHeightFrom(indexPath: IndexPath) -> CGFloat {
        
        return self.getFooterHeightFrom(section: indexPath.section)
    }
    
    internal func getFooterHeightFrom(section: Int) -> CGFloat {
        
        return self.sectionElements[ALSafe: section]?.getFooterHeight() ?? 0.0
    }
    
    internal func getFooterEstimatedHeightFrom(indexPath: IndexPath) -> CGFloat {
        
        return self.getFooterEstimatedHeightFrom(section: indexPath.section)
    }
    
    internal func getFooterEstimatedHeightFrom(section: Int) -> CGFloat {
        
        return self.sectionElements[ALSafe: section]?.getFooterEstimatedHeight() ?? 0.0
    }
    
}
