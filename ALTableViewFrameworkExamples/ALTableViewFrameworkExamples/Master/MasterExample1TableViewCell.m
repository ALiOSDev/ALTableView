//
//  MasterExample1TableViewCell.m
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 20/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "MasterExample1TableViewCell.h"
#import "Example1ViewController.h"

@implementation MasterExample1TableViewCell

-(void) executeAction: (UIViewController *) viewController {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
    } else {
        Example1ViewController * example1 = [[Example1ViewController alloc] init];
        [viewController.navigationController pushViewController:example1 animated:YES];
    }
}



@end
