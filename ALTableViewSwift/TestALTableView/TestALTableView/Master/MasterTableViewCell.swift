//
//  MasterTableViewCell.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 10/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit
import ALTableView

class MasterTableViewCell: UITableViewCell, ALCellProtocol {
    
    static let nib = "MasterTableViewCell"
    static let reuseIdentifier = "MasterTableViewCellReuseIdentifier"
    
    @IBOutlet weak var labelText: UILabel!
    
    public func cellCreated(dataObject: Any?) {
        if let title = dataObject as? String {
            self.labelText.text = title
        }
    }
    
    public func cellPressed(viewController: UIViewController?) {
        self.labelText.text = "Tapped"
    }
    
    func cellDeselected() {
        self.labelText.text = "Deselected"
    }
    
}
