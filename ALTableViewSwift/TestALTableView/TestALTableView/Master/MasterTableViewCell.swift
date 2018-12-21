//
//  MasterTableViewCell.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 10/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit
import ALTableView
import SwipeCellKit

class MasterTableViewCell: SwipeTableViewCell, ALCellProtocol {
    
    static let nib = "MasterTableViewCell"
    static let reuseIdentifier = "MasterTableViewCellReuseIdentifier"
    
    @IBOutlet weak var labelText: UILabel!
    
    public func cellCreated(dataObject: Any?) {
        if let title = dataObject as? String {
            self.labelText.text = title
        }
        delegate = self
    }
    
    public func cellPressed(viewController: UIViewController?) {
        self.labelText.text = "Tapped"
    }
    
    func cellDeselected() {
        self.labelText.text = "Deselected"
    }
    
}

extension MasterTableViewCell: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        var actions = [SwipeAction]()
        switch orientation {
        case .right:
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                print("cell deleted")
                // handle action by updating model with deletion
            }
            actions.append(deleteAction)
            break
        case .left:
            let wishlistAction = SwipeAction(style: .default, title: "Wishlist") { action, indexPath in
                print("cell wishlist")
                // handle action by updating model with deletion
            }
            wishlistAction.backgroundColor = .blue
            actions.append(wishlistAction)
            break
        }
        
        return actions
    }
    
}
