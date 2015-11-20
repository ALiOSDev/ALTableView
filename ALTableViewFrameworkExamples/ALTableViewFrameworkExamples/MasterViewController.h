//
//  MasterViewController.h
//  ALTableViewFrameworkExamples
//
//  Created by Abimael Barea Puyana on 20/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALTableViewController.h"

@class DetailViewController;

@interface MasterViewController : ALTableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

