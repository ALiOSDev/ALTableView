//
//  MasterHeaderFooter.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 22/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit
import ALTableView

class MasterHeaderFooter: UITableViewHeaderFooterView, ALHeaderFooterProtocol {

    static let nib = "MasterHeaderFooter"
    static let reuseIdentifier = "MasterHeaderFooterReuseIdentifier"
    
    @IBOutlet weak var labelText: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func viewCreated(dataObject: Any) {
        if let title: String = dataObject as? String {
            self.labelText.text = title
        }
        
        if #available(iOS 10.0, *) {
            self.contentView.backgroundColor = .green
        } else {
            self.backgroundView = UIView()
            self.backgroundView?.backgroundColor = .green
        }
    }

}
