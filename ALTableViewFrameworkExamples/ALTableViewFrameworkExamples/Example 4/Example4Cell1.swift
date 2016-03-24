//
//  Example4Cell1.swift
//  ALTableViewFrameworkExamples
//
//  Created by Abimael Barea Puyana on 9/1/16.
//  Copyright © 2016 Abimael Barea Puyana. All rights reserved.
//

import UIKit

class Example4Cell1: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    func cellPressed (viewController : UIViewController) {
        label.text = "Tapping cells is funny, huh?"
    }
    
    func cellCreated (object : NSNumber) {
        //label.text = "My height is: "
    }
    
    func cellDeselected () {
        label.text = "Deselected"
    }
}