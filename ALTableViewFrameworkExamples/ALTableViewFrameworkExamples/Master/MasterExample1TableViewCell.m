//
//  MasterExample1TableViewCell.m
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 20/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "MasterExample1TableViewCell.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Example1ViewController.h"

@implementation MasterExample1TableViewCell

-(void) cellPressed: (UIViewController *) viewController {
    Example1ViewController * example1 = [[Example1ViewController alloc] init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [[((MasterViewController *) viewController) detailViewController] setupViewController:example1];
    } else {
        [viewController.navigationController pushViewController:example1 animated:YES];
    }
}



@end
