//
//  ALTableViewEditingManaging.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 20/4/18.
//  Copyright © 2018 ALTableView. All rights reserved.
//

import UIKit

public protocol ALTableViewRowEditingProtocol: class {
    func rowMoved(from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    func rowDeleted(indexPath: IndexPath)
}

extension ALTableView {
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return movingRowsAllowed
    }
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let originSection = self.getSectionElementAt(index: sourceIndexPath.section)
        let destinationSection = self.getSectionElementAt(index: destinationIndexPath.section)
        
        if let originRowElement = originSection?.getRowElementAt(index: sourceIndexPath.row) {
            originSection?.deleteRowElements(numberOfRowElements: 1, at: .middle(sourceIndexPath.row))
            destinationSection?.insert(rowElements: [originRowElement], at: .middle(destinationIndexPath.row))
            editingDelegate?.rowMoved(from: sourceIndexPath, to: destinationIndexPath)
        }
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return editingAllowed
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            if self.remove(at: indexPath, animation: .automatic) {
                editingDelegate?.rowDeleted(indexPath: indexPath)
            }
            
        default:
            break
        }
    }
}
