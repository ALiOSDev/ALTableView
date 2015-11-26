//
//  Example1ViewController.m
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 20/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "Example1ViewController.h"
#import "Example1Cell1.h"
#import "Example1Cell2.h"

@interface Example1ViewController ()

@end

@implementation Example1ViewController


#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Example 1";
    
    [self registerCells];
    [self replaceAllSections:[self createElements]];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Register Cells

-(void) registerCells {
    [self registerClass:[Example1Cell1 class] CellIdentifier:@"Example1Cell1"];
    [self registerClass:[Example1Cell2 class] CellIdentifier:@"Example1Cell2"];
}


#pragma mark - Create Cells

- (NSMutableArray *) createElements {
    // Creamos las secciones
    NSMutableArray * sections = [NSMutableArray array];
    NSMutableArray * rows = [NSMutableArray array];
    
    RowElement * row1 = [[RowElement alloc] initWithClassName:[Example1Cell1 class] object:@40 heightCell:@40 cellIdentifier:nil];
    RowElement * row2 = [[RowElement alloc] initWithClassName:[Example1Cell2 class] object:@60 heightCell:@60 cellIdentifier:nil];
    RowElement * row3 = [[RowElement alloc] initWithClassName:[Example1Cell1 class] object:@80 heightCell:@80 cellIdentifier:nil];
    RowElement * row4 = [[RowElement alloc] initWithClassName:[Example1Cell2 class] object:@100 heightCell:@100 cellIdentifier:nil];
    RowElement * row5 = [[RowElement alloc] initWithClassName:[Example1Cell1 class] object:@120 heightCell:@120 cellIdentifier:nil];
    RowElement * row6 = [[RowElement alloc] initWithClassName:[Example1Cell2 class] object:@140 heightCell:@140 cellIdentifier:nil];
    RowElement * row7 = [[RowElement alloc] initWithClassName:[UITableViewCell class] object:@40 heightCell:@40 cellIdentifier:nil CellStyle:UITableViewCellStyleSubtitle CellPressedHandler:^(UIViewController * viewController, UITableViewCell * cell) {
        
        cell.textLabel.text = @"Cell selected";        
    } CellCreatedHandler:^(NSNumber * object, UITableViewCell * cell)  {
        cell.textLabel.text = [NSString stringWithFormat:@"My height is: %@",[object stringValue]];
        cell.detailTextLabel.text = @"hola";
    } CellDeselectedHandler:^(UITableViewCell * cell) {
        cell.textLabel.text = @"Cell deselected";
    }];

    [rows addObject:row1];
    [rows addObject:row2];
    [rows addObject:row3];
    [rows addObject:row4];
    [rows addObject:row5];
    [rows addObject:row6];
    [rows addObject:row7];
    
    SectionElement * sectionElement = [[SectionElement alloc] initWithSectionTitleIndex:nil viewHeader:nil viewFooter:nil heightHeader:@0 heightFooter:@0 cellObjects:rows isExpandable:NO];
    
    [sections addObject:sectionElement];
    return sections;
}

@end
