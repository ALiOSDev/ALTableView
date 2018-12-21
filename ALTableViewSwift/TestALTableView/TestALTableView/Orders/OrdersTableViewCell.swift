//
//  OrdersTableViewCell.swift
//  bimbaylola
//
//  Created by Michel Goñi on 07/12/2018.
//  Copyright © 2018 BimbaYLola. All rights reserved.
//

import UIKit
import ALTableView

protocol  OrdersElementConfigurable {
    func configure(element: OrderRepresentable)
}

protocol OrderIdProtocol: class {
    func orderIdSelected(orderId: Int)
}

class OrdersTableViewCell: UITableViewCell, ALCellProtocol, OrdersElementConfigurable {
  
    @IBOutlet weak var lbOrderId: UILabel!
    @IBOutlet weak var lbOrderDate: UILabel!
    @IBOutlet weak var imgOrderStatus: UIImageView!
    @IBOutlet weak var lbOrderStatus: UILabel!
    @IBOutlet weak var lbOrderAmount: UILabel!
    
    private var element: OrderRepresentable?
    
    class var nib: String {
        return "OrdersTableViewCell"
    }
    class var reuseIdentifier: String {
        return "OrdersTableViewCellReuseIdentifier"
    }
    
    // MARK: - ALCellProtocol
    
    public func cellCreated(dataObject: Any?) {
        if let element = dataObject as? OrderRepresentable {
            self.element = element
            configure(element: element)
        }
      
    }
    
    func cellPressed(viewController: UIViewController?) {
        
        if let orderid = element?.orderId {
            element?.delegate?.orderIdSelected(orderId: Int(orderid.text) ?? 0)
        }
     
    }
    
    // MARK: - OrdersElementConfigurable
    func configure(element: OrderRepresentable) {
        lbOrderId.configure(textConfigurable: TextStyles.ordersElement(text: element.orderId.text))
        lbOrderDate.configure(textConfigurable: TextStyles.ordersElementDate(text: element.orderCreationDate.string(withFormat: "dd/MM/yyyy")))
        imgOrderStatus.layer.masksToBounds = true
        imgOrderStatus.layer.cornerRadius = imgOrderStatus.frame.height / 2
        imgOrderStatus.image = element.orderStatusType?.retrieveStatusColor().image(CGSize(width: 14, height: 14))
        lbOrderStatus.configure(textConfigurable: TextStyles.ordersElement(text: element.orderStatus.text))
        lbOrderAmount.configure(textConfigurable: TextStyles.ordersElement(text: element.orderAmount.text))
    }
    
}

extension UILabel {
    
    func configure(textConfigurable: TextConfigurableProtocol) {
        text = textConfigurable.text
        font = textConfigurable.font
        textColor = textConfigurable.color
        textAlignment = textConfigurable.alignment
    }
    
}

extension UIColor {
    
    /// Prints color inside an image
    /// - parameter size:        The size of the image as CGSize.
    /// - Example: UIColor.red.image(CGSize(width: 35, height: 35)).
    public func image(_ size: CGSize = CGSize(width: 35, height: 35)) -> UIImage {
        if #available(iOS 10.0, *) {
            return UIGraphicsImageRenderer(size: size).image { rendererContext in
                self.setFill()
                rendererContext.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
            }
        } else {
            return UIImage()
        }
    }
}

extension Date {
    public func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
