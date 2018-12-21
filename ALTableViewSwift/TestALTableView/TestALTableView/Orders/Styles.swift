//
//  Styles.swift
//  BimbaYLola
//
//  Created by lorenzo villarroel perez on 25/9/18.
//  Copyright © 2018 BimbaYLola. All rights reserved.
//

import UIKit

struct TextStyles {

    
    static func ordersElement(text: String) -> TextConfigurable {
        return TextConfigurable(text: text, font: UIFont.systemFont(ofSize: 14), color: .black, alignment: .left)
    }
    
    static func ordersElementDate(text: String) -> TextConfigurable {
        return TextConfigurable(text: text, font: UIFont.systemFont(ofSize: 14), color: .black, alignment: .left)
    }
    

}
