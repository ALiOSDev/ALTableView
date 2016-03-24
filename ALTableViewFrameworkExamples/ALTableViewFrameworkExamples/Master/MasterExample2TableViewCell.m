//
//  MasterExample2TableViewCell.m
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 20/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "MasterExample2TableViewCell.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Example2ViewController.h"

@implementation MasterExample2TableViewCell

-(void) cellPressed: (UIViewController *) viewController {
    Example2ViewController * example1 = [[Example2ViewController alloc] init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [[((MasterViewController *) viewController) detailViewController] setupViewController:example1];
    } else {
        [viewController.navigationController pushViewController:example1 animated:YES];
    }
}

@end
