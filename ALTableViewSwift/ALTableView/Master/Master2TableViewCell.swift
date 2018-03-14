//
//  Master2TableViewCell.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 14/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

class Master2TableViewCell: UITableViewCell, ALCellProtocol {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func cellCreated(dataObject: Any) {
        if let title = dataObject as? Int {
            self.label.text = String(title)
        }
    }
    
}
