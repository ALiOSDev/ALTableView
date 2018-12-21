//
//  LoadingRetryTableViewCell.swift
//  BimbaYLola
//
//  Created by lorenzo villarroel perez on 20/12/2018.
//  Copyright © 2018 BimbaYLola. All rights reserved.
//

import UIKit
import ALTableView

class LoadingRetryTableViewCell: UITableViewCell, ALCellProtocol {

    @IBOutlet weak var btShowMore: SecondaryButton!
    
    class var nib: String {
        return "LoadingRetryTableViewCell"
    }
    class var reuseIdentifier: String {
        return "LoadingRetryTableViewCellReuseIdentifier"
    }
    
    func cellCreated(dataObject: Any?) {
        btShowMore.isUserInteractionEnabled = false
        btShowMore.setTitle("PRODUCTS_GRID_SHOW_MORE", for: .normal)
    }

}

class SecondaryButton: UIButton {
    
    override var intrinsicContentSize: CGSize {
        get {
            let baseSize = super.intrinsicContentSize
            return CGSize(width: baseSize.width + titleEdgeInsets.left + titleEdgeInsets.right,
                          height: baseSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
        }
        set {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        
        backgroundColor = .white
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        
        titleEdgeInsets =  UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
       
        
    }
    
}
