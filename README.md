ALTableView
==============

Download
--------

This framework is still on development. We cannot guarantee yet that all the features work.

How it works
--------

This framework inherit from UITableViewController and manage the delegate and datasource of UITableView for you. For doing that you only need to create  SectionElement array and for each one a RowElement array.

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
- **executeAction** receive the current viewController and represents the actions when cell is pressed
- **configureCell** receive like parameter the data that you want to show in the cell
- **cellDeselected** it is call when your cell is deselected

```objective-c

#import "Example1Cell1.h"

@implementation Example1Cell1

-(void) executeAction: (UIViewController *) viewController {
    self.label.text = @"Tapping cells is funny, huh?";
}

-(void) configureCell: (NSNumber *) object {
    self.label.text = [NSString stringWithFormat:@"My height is: %@",[object stringValue]];
}

-(void) cellDeselected {
    self.label.text = [NSString stringWithFormat:@"deselected"];
}

@end

```

Create a RowElement that encapsules your cell and data

```objective-c

RowElement * row1 = [[RowElement alloc] initWithClassName:[Example1Cell1 class] object:@40 heightCell:@40 cellIdentifier:nil];

```

If you don't want to implement the 3 methods you can use blocks instead

```objective-c

RowElement * row2 = [[RowElement alloc] initWithClassName:[UITableViewCell class] object:@40 heightCell:@40 cellIdentifier:nil CellStyle:UITableViewCellStyleSubtitle 
    CellPressedHandler:^(UIViewController * viewController, UITableViewCell * cell) {
        cell.textLabel.text = @"Cell selected";
    } CellCreatedHandler:^(NSNumber * object, UITableViewCell * cell)  {
        cell.textLabel.text = [NSString stringWithFormat:@"My height is: %@",[object stringValue]];
        cell.detailTextLabel.text = @"hola";
    } CellDeselectedHandler:^(UITableViewCell * cell) {
        cell.textLabel.text = @"Cell deselected";
    }];
    
```

Example of Custom TableView
--------

You can inherit from ALTableView just like if you inherit from a UITableViewController.

```objective-c

- (void)viewDidLoad {
    [super viewDidLoad];

    [self registerCells];
    [self replaceAllSectionElements:[self createElements]];
}

-(void) registerCells {
    [self registerClass:[Example1Cell1 class] CellIdentifier:@"Example1Cell1"];
}

- (NSMutableArray *) createElements {
    NSMutableArray * sections = [NSMutableArray array];
    NSMutableArray * rows = [NSMutableArray array];
    
    // Declare your cells and actions
    RowElement * row1 = [[RowElement alloc] initWithClassName:[Example1Cell1 class] object:@40 heightCell:@40 cellIdentifier:nil];
    RowElement * row2 = [[RowElement alloc] initWithClassName:[UITableViewCell class] object:@40 heightCell:@40 cellIdentifier:nil CellStyle:UITableViewCellStyleSubtitle 
    CellPressedHandler:^(UIViewController * viewController, UITableViewCell * cell) {
        cell.textLabel.text = @"Cell selected";
    } CellCreatedHandler:^(NSNumber * object, UITableViewCell * cell)  {
        cell.textLabel.text = [NSString stringWithFormat:@"My height is: %@",[object stringValue]];
        cell.detailTextLabel.text = @"hola";
    } CellDeselectedHandler:^(UITableViewCell * cell) {
        cell.textLabel.text = @"Cell deselected";
    }];
    
    [rows addObject:row1];
    [rows addObject:row2];
    
    // Create a section
    SectionElement * sectionElement = [[SectionElement alloc] initWithSectionTitleIndex:nil viewHeader:nil viewFooter:nil heightHeader:@0 heightFooter:@0 cellObjects:rows isExpandable:NO];
    
    [sections addObject:sectionElement];
    return sections;
}

```

And now in your Swift code.

```swift


 override func viewDidLoad() {
    super.viewDidLoad()

    registerCells()
    replaceAllSectionElements(createElements())
 }
        
func registerCells() {
    self.registerClass(Example4Cell1.classForCoder(), cellIdentifier: "Example4Cell1")
}
    
func createElements() -> NSMutableArray {
    let sections = NSMutableArray()
    let rows = NSMutableArray()
    
    let row1 = RowElement.init(className: Example4Cell1.classForCoder(), object: 40, heightCell: 60, cellIdentifier: nil)
    let row2 = RowElement.init(className: UITableViewCell.classForCoder(), object: 40, heightCell: 60, cellIdentifier: nil, cellStyle: UITableViewCellStyle.Subtitle,
        cellPressedHandler: { viewController, cell in
            cell.textLabel!!.text = "Cell selected"
            cell.detailTextLabel!!.text = "adios"
        },
        cellCreatedHandler: { (object, cell) -> Void in
            cell.textLabel!!.text = "My height is: " + object.stringValue
            cell.detailTextLabel!!.text = "Hola"
        },
        cellDeselectedHandler: { (cell) -> Void in
            cell.textLabel!!.text = "Cell deselected"
    })
    
    rows.addObject(row1)
    rows.addObject(row2)
    
    let sectionElement = SectionElement.init(sectionTitleIndex: nil, viewHeader: nil, viewFooter: nil, heightHeader: 0, heightFooter: 0, cellObjects: rows, isExpandable: false)
    sections.addObject(sectionElement)
    
    return sections;
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


