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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Example 1";
    
    [self registerCells];
    [self reloadAllSections:[self createElements]];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) registerCells {
    [self registerClass:[Example1Cell1 class] CellIdentifier:@"Example1Cell1"];
    [self registerClass:[Example1Cell2 class] CellIdentifier:@"Example1Cell2"];
}


// Professional Example

- (NSMutableArray *) createElements {
    
    // Creamos las secciones
    NSMutableArray * sections = [NSMutableArray array];
    NSMutableArray * rows = [NSMutableArray array];
    RowElement * row1 = [[RowElement alloc] initWithClassName:[Example1Cell1 class] object:@44 heightCell:@44 cellIdentifier:nil];
    
    
    RowElement * row2 = [[RowElement alloc] initWithClassName:[Example1Cell2 class] object:@60 heightCell:@60 cellIdentifier:nil];
    
    [rows addObject:row1];
    [rows addObject:row2];
    
    SectionElement * sectionElement = [[SectionElement alloc] initWithSectionTitleIndex:nil viewHeader:nil viewFooter:nil heightHeader:@0 heightFooter:@0 cellObjects:rows];
    
    [sections addObject:sectionElement];
    
    return sections;
}

@end
