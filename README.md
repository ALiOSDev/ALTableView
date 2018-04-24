ALTableView
==============

Installation
--------

The development of the Objective-C part of this project has been discontinued. The latest stable version of the Objective-C code is in the version [0.1.1](https://github.com/ALiOSDev/ALTableView/tree/0.1.1)

This framework is still on development. We cannot guarantee yet that all the features work.

The latest stable version for swift is  [0.1.6](https://github.com/ALiOSDev/ALTableView/tree/0.1.6)


**CocoaPods**

To integrate ALTableView into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'ALTableView', '~> 0.1.6'
end
```

Alternatively, you can try adding [these classes](https://github.com/ALiOSDev/ALTableView/tree/master/ALTableViewSwift/ALTableView/ALTableView/ALTableViewClasses) to your project.

Requirements
--------

Swift 4.0
iOS 9.0

How it works
--------

This framework is a generic UITableViewDataSource and UITableViewDelegate which will help you to reduce all the code you have to copy-paste everytime you create a tableView. For doing that you only need to create  SectionElement array and for each one a RowElement array.

<img src="https://github.com/ALiOSDev/ALTableView/blob/master/screenshots/ALTableViewDiagram.png">

**SectionElement** (Represents a section of UITableView)
- Provide your customs header and footer views
- Do your section COLLAPSABLE with just a boolean value 

**RowElement** (Contains a UITableViewCell and the data for it)
- We create your cells and bind the data that you provide us 
- Each cell could have a different layout and do diferrent actions 

Create your cells and we manage them
--------

Easy to use, just inherit from UITableViewCell, and implement those 3 methods. 
- **cellPressed** receive the current viewController and represents the actions when cell is pressed
- **cellCreated** receive like parameter the data that you want to show in the cell
- **cellDeselected** it is call when your cell is deselected

```swift

import UIKit
import ALTableView

class MasterTableViewCell: UITableViewCell, ALCellProtocol {
    
    static let nib = "MasterTableViewCell"
    static let reuseIdentifier = "MasterTableViewCellReuseIdentifier"
    
    @IBOutlet weak var labelText: UILabel!
    
    public func cellCreated(dataObject: Any) {
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

```

Create a RowElement that encapsules your cell and data

```swift

let rowElement = ALRowElement(className:MasterTableViewCell.classForCoder(), identifier: MasterTableViewCell.reuseIdentifier, dataObject: "Cell text", estimateHeightMode: true)

```

If you don't want to implement the 3 methods you can use blocks instead

```swift

let rowElement = ALRowElement(className: MasterTableViewCell.classForCoder(), identifier: MasterTableViewCell.reuseIdentifier, dataObject: "Cell text", estimateHeightMode: true, pressedHandler: { (viewController, cell) in
                if let cell = cell as? MasterTableViewCell {
                    cell.labelText.text = "Tapped"
                }
                
            }, createdHandler: { (dataObject, cell) in
                if let title = dataObject as? String, let cell = cell as? MasterTableViewCell {
                    cell.labelText.text = title
                }
            }) { (cell) in
                if let cell = cell as? MasterTableViewCell {
                    cell.labelText.text = "Deselected"
                }
            }
```

Example of ALTableView
--------


```swift

import UIKit
import ALTableView

class MasterViewController: UITableViewController {
    
    var alTableView: ALTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sectionElements = self.createElements()
        
        self.alTableView = ALTableView(sectionElements: sectionElements, viewController: self, tableView: self.tableView)
        self.registerCells()
        self.tableView.delegate = self.alTableView
        self.tableView.dataSource = self.alTableView
        self.tableView.reloadData()
    }
    
    func createElements() -> [ALSectionElement] {
        var sectionElements = [ALSectionElement]()
        for _ in 0...2 { //Typically you will iterate over your datasource
            var rowElements = Array<ALRowElement>()
            let rowElement = ALRowElement(className:MasterTableViewCell.classForCoder(), identifier: MasterTableViewCell.reuseIdentifier, dataObject: "Cell text", estimateHeightMode: true)
            rowElements.append(rowElement)

            let section = ALSectionElement(rowElements: rowElements, headerElement: nil, footerElement: nil, isExpandable: true)
            sectionElements.append(section)
        }
        
        return sectionElements
    }
    
    func registerCells() {
        self.alTableView?.registerCell(nibName: MasterTableViewCell.nib, reuseIdentifier: MasterTableViewCell.reuseIdentifier)

    }
}

```

Authors
--------

Abimael Barea [@elabi3](https://github.com/elabi3) - 
Lorenzo Villarroel [@lorencr7](https://github.com/lorencr7) 

License
-------

	The MIT License (MIT)

	Copyright (c) 2015 ALiOSDev

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.


