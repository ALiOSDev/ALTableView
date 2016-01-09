//
//  MasterViewController.m
//  ALTableViewFrameworkExamples
//
//  Created by Abimael Barea Puyana on 20/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MasterTableViewCell.h"
#import "MasterExample1TableViewCell.h"
#import "MasterExample2TableViewCell.h"
#import "MasterExample3TableViewCell.h"
#import "MasterExample4TableViewCell.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController


#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self registerCells];
    [self replaceAllSectionElements:[self createElements]];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Register Cells

-(void) registerCells {
    [self registerClass:[MasterTableViewCell class] CellIdentifier:@"MasterTableViewCell"];
}


#pragma mark - Create Cells

- (NSMutableArray *) createElements {
    // Creamos las secciones
    NSMutableArray * sections = [NSMutableArray array];
    
    NSMutableArray * rows = [NSMutableArray array];
    NSNumber * height = [NSNumber numberWithFloat:UITableViewAutomaticDimension];
    
    RowElement * example1 = [[RowElement alloc] initWithClassName:[MasterExample1TableViewCell class] object:@"Example 1" heightCell:height cellIdentifier:@"MasterTableViewCell"];
    [rows addObject:example1];
    example1.estimateHeightMode = YES;

    RowElement * example2 = [[RowElement alloc] initWithClassName:[MasterExample2TableViewCell class] object:@"Example 2 Index Table View" heightCell:height cellIdentifier:@"MasterTableViewCell"];
    [rows addObject:example2];
    example2.estimateHeightMode = YES;
    
    RowElement * example3 = [[RowElement alloc] initWithClassName:[MasterExample3TableViewCell class] object:@"Example 3 Twitter Timeline with automatic dimension cells" heightCell:height cellIdentifier:@"MasterTableViewCell"];
    [rows addObject:example3];
    example3.estimateHeightMode = YES;
    
    RowElement * example4 = [[RowElement alloc] initWithClassName:[MasterExample4TableViewCell class] object:@"Example 4 Swift" heightCell:height cellIdentifier:@"MasterTableViewCell"];
    [rows addObject:example4];
    example4.estimateHeightMode = YES;
    
    SectionElement * sectionElement = [[SectionElement alloc] initWithSectionTitleIndex:nil viewHeader:nil viewFooter:nil heightHeader:@0 heightFooter:@0 cellObjects:rows isExpandable:NO];
    
    [sections addObject:sectionElement];
    return sections;
}

@end
