//
//  Example1Cell2.m
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 20/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "Example1Cell2.h"

@implementation Example1Cell2

-(void) executeAction: (UIViewController *) viewController {
    self.label.text = @"Stop tapping me!!";
}

-(void) configureCell: (NSNumber *) object {
    self.label.text = [NSString stringWithFormat:@"My height is: %@",[object stringValue]];
}

-(void) cellDeselected {
    self.label.text = [NSString stringWithFormat:@"deselected"];
}

@end
