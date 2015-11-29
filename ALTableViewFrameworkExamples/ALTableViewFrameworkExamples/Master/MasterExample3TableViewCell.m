//
//  MasterExample3TableViewCell.m
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 29/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "MasterExample3TableViewCell.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Example3ViewController.h"

@implementation MasterExample3TableViewCell

-(void) executeAction: (UIViewController *) viewController {
    Example3ViewController * example1 = [[Example3ViewController alloc] init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [[((MasterViewController *) viewController) detailViewController] setupViewController:example1];
    } else {
        [viewController.navigationController pushViewController:example1 animated:YES];
    }
}

@end
