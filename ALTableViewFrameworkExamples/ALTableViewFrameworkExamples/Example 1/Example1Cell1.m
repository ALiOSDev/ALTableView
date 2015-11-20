//
//  Example1Cell1.m
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 20/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "Example1Cell1.h"

@implementation Example1Cell1

-(void) executeAction: (UIViewController *) viewController {
    self.label.text = @"Tapping cells is funny, huh?";
}

-(void) configureCell: (NSNumber *) object {
    self.label.text = [NSString stringWithFormat:@"My height is: %@",[object stringValue]];
}
@end
