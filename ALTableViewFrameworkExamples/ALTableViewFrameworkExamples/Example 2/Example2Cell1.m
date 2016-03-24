//
//  Example2Cell1.m
//  ALTableViewFrameworkExamples
//
//  Created by Abimael Barea Puyana on 21/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "Example2Cell1.h"

@implementation Example2Cell1

-(void) cellPressed: (UIViewController *) viewController {
    NSLog(@"%@",self.titleLabel.text);
}

-(void) cellCreated: (NSString *) object {
    self.titleLabel.text = [NSString stringWithString:object];
}

@end
