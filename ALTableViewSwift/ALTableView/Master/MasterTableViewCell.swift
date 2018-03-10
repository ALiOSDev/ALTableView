//
//  MasterTableViewCell.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 10/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell, ALCellProtocol {
    
    @IBOutlet weak var labelText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func cellCreated(dataObject: Any) {
        if let title = dataObject as? String {
            self.labelText.text = title
        }
    }
    
    public func cellPressed(viewController: UIViewController?) {
        print(self.labelText.text)
    }
    
//    func cellCreated(dataObject: Any) {
//        
//    }
    
}
