//
//  LoadingTableViewCell.swift
//  bimbaylola
//
//  Created by lorenzo villarroel perez on 20/12/2018.
//  Copyright © 2018 BimbaYLola. All rights reserved.
//

import UIKit
import ALTableView

class LoadingTableViewCell: UITableViewCell, ALCellProtocol {

    class var nib: String {
        return "LoadingTableViewCell"
    }
    class var reuseIdentifier: String {
        return "LoadingTableViewCellReuseIdentifier"
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func cellCreated(dataObject: Any?) {
        activityIndicator.startAnimating()
    }
    
}
