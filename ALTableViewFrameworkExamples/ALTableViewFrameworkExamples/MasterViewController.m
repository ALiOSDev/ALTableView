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

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

//    self.modeSectionsIndexTitles = YES;
//    self.modeSectionsExpandable = YES;
//    self.modeMoveCells = YES;
    [self registerCells];
    [self reloadAllSections:[self createElements]];
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


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}




-(void) registerCells {
    [self registerClass:[MasterTableViewCell class] CellIdentifier:@"MasterTableViewCell"];
}


// Professional Example

- (NSMutableArray *) createElements {
    
    // Creamos las secciones
    NSMutableArray * sections = [NSMutableArray array];
    NSMutableArray * rows = [NSMutableArray array];
    RowElement * example1 = [[RowElement alloc] initWithClassName:[MasterExample1TableViewCell class] object:@"Example 1" heightCell:@44 cellIdentifier:@"MasterTableViewCell"];
    
    RowElement * example2 = [[RowElement alloc] initWithClassName:[MasterExample2TableViewCell class] object:@"Example 2" heightCell:@44 cellIdentifier:@"MasterTableViewCell"];
    
    [rows addObject:example1];
    [rows addObject:example2];
    
    SectionElement * sectionElement = [[SectionElement alloc] initWithSectionTitleIndex:nil viewHeader:nil viewFooter:nil heightHeader:@0 heightFooter:@0 cellObjects:rows];
    
    [sections addObject:sectionElement];
    
    return sections;
}

@end
