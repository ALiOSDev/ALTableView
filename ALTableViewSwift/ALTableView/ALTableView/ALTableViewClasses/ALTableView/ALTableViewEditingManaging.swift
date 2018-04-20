//
//  ALTableViewEditingManaging.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 20/4/18.
//  Copyright © 2018 ALTableView. All rights reserved.
//

import UIKit

extension ALTableView {
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let originSection = self.getSectionElementAt(index: sourceIndexPath.section)
        let destinationSection = self.getSectionElementAt(index: destinationIndexPath.section)
        
        if let originRowElement = originSection?.getRowElementAt(index: sourceIndexPath.row) {
            originSection?.deleteRowElements(numberOfRowElements: 1, at: .middle(sourceIndexPath.row))
            destinationSection?.insert(rowElements: [originRowElement], at: .middle(destinationIndexPath.row))
        }
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            self.remove(at: indexPath)
        default:
            break
        }
    }
}
