//
//  MasterExample3TableViewCell.m
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 29/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "MasterExample4TableViewCell.h"
#import "MasterViewController.h"
#import "DetailViewController.h"

#import "ALTableViewFrameworkExamples-Swift.h"

@implementation MasterExample4TableViewCell

-(void) cellPressed: (UIViewController *) viewController {
    TableViewExample4 * example4 = [[TableViewExample4 alloc] init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [[((MasterViewController *) viewController) detailViewController] setupViewController:example4];
    } else {
        [viewController.navigationController pushViewController:example4 animated:YES];
    }
}

@end
