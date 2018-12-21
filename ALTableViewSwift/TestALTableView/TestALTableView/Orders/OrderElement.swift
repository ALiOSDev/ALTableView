//
//  OrderElement.swift
//  bimbaylola
//
//  Created by Michel Goñi on 07/12/2018.
//  Copyright © 2018 BimbaYLola. All rights reserved.
//

import UIKit

enum DeliveryStatus: String {
    case delivered
    case pickUp
    case incidence
    case processing
    case preparing
    case shipped
    case unknown
    
    func retrieveStatusColor() -> UIColor {
        
        switch self {
        case .delivered:
            return .green
        case .pickUp:
             return .blue
        case .incidence:
             return .purple
        case .processing:
             return .orange
        case .preparing:
             return .yellow
        case .shipped:
             return .blue
        case .unknown:
            return .blue
        }
    }
}

protocol OrderRepresentable {
    var image: UIImage? { get  }
    var orderId: TextConfigurableProtocol { get  }
    var orderAmount: TextConfigurableProtocol { get }
    var orderCreationDate: Date { get }
    var orderStatus: TextConfigurableProtocol { get  }
    var orderStatusType: DeliveryStatus? {get}
    var delegate: OrderIdProtocol? {get}
}

struct OrderElement: OrderRepresentable {
   
    var image: UIImage?
    var orderId: TextConfigurableProtocol
    var orderAmount: TextConfigurableProtocol
    var orderCreationDate: Date
    var orderStatus: TextConfigurableProtocol
    var orderStatusType: DeliveryStatus?
    weak var delegate: OrderIdProtocol?
    
    init(image: UIImage? = nil,orderId: TextConfigurableProtocol,orderAmount: TextConfigurableProtocol,orderCreationDate:Date, orderStatus: TextConfigurableProtocol, delegate: OrderIdProtocol?) {
        
        self.image = image
        self.orderId = orderId
        self.orderAmount = orderAmount
        self.orderCreationDate = orderCreationDate
        self.orderStatus = orderStatus
        self.orderStatusType = getStatus(orderStatus: self.orderStatus.text)
        self.delegate = delegate
        
    }
    
    // MARK: - Private methods
    private func getStatus(orderStatus: String) -> DeliveryStatus {
        
        return DeliveryStatus(rawValue: orderStatus) ??  .unknown

    }
}


protocol TextConfigurableProtocol {
    var text: String { get set }
    var font: UIFont { get set }
    var color: UIColor { get set }
    var alignment: NSTextAlignment { get set }
    func isEmpty() -> Bool
}

extension TextConfigurableProtocol {
    func isEmpty() -> Bool {
        return text.isEmpty
    }
}

struct TextConfigurable: TextConfigurableProtocol {
    var text: String
    var font: UIFont
    var color: UIColor
    var alignment: NSTextAlignment
    
    static func defaultEmptyMember() -> TextConfigurable {
        return TextConfigurable(text: "", font: UIFont.systemFont(ofSize: 16.0), color: .black, alignment: .left)
    }
    
    static func defaultMember () -> TextConfigurable {
        return TextConfigurable(text: " ", font: UIFont.systemFont(ofSize: 16.0), color: .black, alignment: .left)
    }
}

