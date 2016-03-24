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
#import "Example1Cell3.h"

@interface Example1ViewController ()

@end

@implementation Example1ViewController


#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Example 1";
    [self registerCells];
    [self replaceAllSectionElements:[self createElements]];
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
    [self registerClass:[Example1Cell2 class] CellIdentifier:@"Example1Cell3"];
}


#pragma mark - Create Cells

- (NSMutableArray *) createElements {
    // Build Sections
    NSMutableArray * sections = [NSMutableArray array];
    NSMutableArray * rows = [NSMutableArray array];
    
    
    // First section ************
    
    [rows addObject:[RowElement rowElementWithClassName:[Example1Cell2 class] object:@60 heightCell:@60]];
    
    RowElement * row2 = [RowElement rowElementWithClassName:[Example1Cell1 class] object:@80 heightCell:@80 cellIdentifier:@"Example1Cell1"];
    [rows addObject:row2];

    RowElement * row3 = [RowElement rowElementWithClassName:[UITableViewCell class] object:@40 heightCell:@40 cellIdentifier:nil CellStyle:UITableViewCellStyleSubtitle
                                         CellPressedHandler:^(UIViewController * viewController, UITableViewCell * cell) {
                                             cell.textLabel.text = @"Cell selected";
                                             
                                             for (NSDictionary *dic in [[self retrieveAllElements] allValues]) {
                                                 NSLog(@"%@", dic);
                                             }
                                         } CellCreatedHandler:^(NSNumber * object, UITableViewCell * cell) {
                                             cell.textLabel.text = [NSString stringWithFormat:@"My height is: %@",[object stringValue]];
                                             cell.detailTextLabel.text = @"hola";
                                         } CellDeselectedHandler:^(UITableViewCell * cell) {
                                             cell.textLabel.text = @"Cell deselected";
                                         }];
    [rows addObject:row3];
    
    SectionElement * sectionElement = [SectionElement sectionElementWithSectionTitleIndex:nil viewHeader:nil viewFooter:nil heightHeader:@0 heightFooter:@0 cellObjects:rows isExpandable:NO];
    [sections addObject:sectionElement];
    
    
    // Second section ************
    
    rows = [NSMutableArray array];
    
    NSDictionary *params2 = @{
                             PARAM_ROWELEMENT_CLASS:[UITableViewCell class],
                             PARAM_ROWELEMENT_OBJECT:@40,
                             PARAM_ROWELEMENT_HEIGHTCELL:@40,
                             PARAM_ROWELEMENT_CELL_STYLE:[NSNumber numberWithLong:UITableViewCellStyleSubtitle],
                             PARAM_ROWELEMENT_CELL_PRESSED:^(UIViewController * viewController, UITableViewCell * cell) {
                                 cell.textLabel.text = @"Cell selected";
                             },
                             PARAM_ROWELEMENT_CELL_CREATED:^(NSNumber * object, UITableViewCell * cell) {
                                 cell.textLabel.text = [NSString stringWithFormat:@"My height is: %@",[object stringValue]];
                                 cell.detailTextLabel.text = @"hola";
                             }};
    [rows addObject:[RowElement rowElementWithParams:params2]];

    NSDictionary *params3 = @{
                             PARAM_ROWELEMENT_CLASS:[Example1Cell3 class],
                             PARAM_ROWELEMENT_OBJECT:@140,
                             PARAM_ROWELEMENT_HEIGHTCELL:@200
                             };
    [rows addObject:[RowElement rowElementWithParams:params3]];
    
    UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    labelTitle.text = @"Section 2 Header";
    labelTitle.backgroundColor = [UIColor greenColor];
    
    NSDictionary *paramsSection = @{
                              PARAM_SECTIONELEMENT_VIEW_HEADER:labelTitle,
                              PARAM_SECTIONELEMENT_HEIGHT_HEADER:@40,
                              PARAM_SECTIONELEMENT_CELL_OBJECTS:rows,
                              PARAM_SECTIONELEMENT_IS_EXPANDABLE:[NSNumber numberWithBool:YES]
                              };    
    [sections addObject:[SectionElement sectionElementWithParams:paramsSection]];
    
    return sections;
}

@end
