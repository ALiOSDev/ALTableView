//
//  ALElement.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 20/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

public class ALElement {
    
    internal var estimateHeightMode: Bool
    internal var height: CGFloat
    internal let identifier: String
    internal let dataObject: Any?
    
    
    init(identifier: String, dataObject: Any?, estimateHeightMode: Bool, height: CGFloat) {
        
        self.identifier = identifier
        self.dataObject = dataObject
        self.estimateHeightMode = estimateHeightMode
        self.height = height
    }
    
    //MARK: - Getters
    
    internal func getDataObject() -> Any? {
        
        return self.dataObject
    }
    
    internal func getEstimatedHeight() -> CGFloat {
        
        return self.height
    }
    
    internal func getHeight() -> CGFloat {
        if self.estimateHeightMode {
            return UITableView.automaticDimension
        }
        return self.height
    }
    
    internal func isEstimateHeightMode() -> Bool {
        
        return self.estimateHeightMode
    }

}
