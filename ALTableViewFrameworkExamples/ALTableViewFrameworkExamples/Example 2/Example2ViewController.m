//
//  Example2.m
//  ALTableViewFrameworkExamples
//
//  Created by Abimael Barea Puyana on 21/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "Example2ViewController.h"
#import "Example2Cell1.h"

@interface Example2ViewController ()

@end

@implementation Example2ViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Example 2";
    
    // Cofigure settings of tableView
    self.modeSectionsIndexTitles = YES;
    self.modeMoveCells = YES;

    [self addPullToRefreshWithBackgroundColor:[UIColor yellowColor] refreshColor:[UIColor whiteColor] title:@"Refresh" titleColor:[UIColor redColor]];
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
    [self registerClass:[Example2Cell1 class] CellIdentifier:@"Example2Cell1"];
}


#pragma mark - Create Cells

- (NSMutableArray *) createElements {
    NSMutableArray *sourceData = [NSMutableArray arrayWithObjects:@"Aadi", @"Abimael", @"Bruno", @"Bárcenas", @"Lorenzo", @"Lidia", @"Lucas", @"Lola", @"Maria", @"Mario", @"Marcos", @"Matías", nil];
    
    sourceData = [self replaceFirstCharAccent:sourceData];
    NSMutableArray * firstLetters = [self getFirstLettersInArray:sourceData];
    
    // Creamos las secciones
    NSMutableArray * sections = [NSMutableArray array];
    
    for (NSString *firsLetterTitle in firstLetters) {
        NSString * sectionTitleIndex = firsLetterTitle;
        NSMutableArray * rowsSourceData = [NSMutableArray array];
        
        /*for (NSString * element in sourceData) {
            if ([firsLetterTitle isEqualToString:[element substringToIndex:1]]) {
                [rowsSourceData addObject:[RowElement rowElementWithClassName:[Example2Cell1 class] object:element heightCell:@44 cellIdentifier:nil]];
            }
        }
        
        UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        labelTitle.text = sectionTitleIndex;
        labelTitle.backgroundColor = [UIColor greenColor];
        [sections addObject:[SectionElement sectionElementWithSectionTitleIndex:sectionTitleIndex viewHeader:labelTitle viewFooter:nil heightHeader:@40 heightFooter:nil cellObjects:rowsSourceData isExpandable:YES]];*/
        
        for (NSString * element in sourceData) {
            if ([firsLetterTitle isEqualToString:[element substringToIndex:1]]) {
                [rowsSourceData addObject:element];
            }
        }
        
        UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        labelTitle.text = sectionTitleIndex;
        labelTitle.backgroundColor = [UIColor greenColor];
        [sections addObject:[SectionElement sectionElementWithSectionTitleIndex:sectionTitleIndex viewHeader:labelTitle viewFooter:nil heightHeader:@40 heightFooter:nil sourceData:rowsSourceData classForRow:[Example2Cell1 class] isExpandable:YES]];
    }
    
    return sections;
}


#pragma mark - Auxiliar: sort elements

- (NSMutableArray *) replaceFirstCharAccent: (NSMutableArray *) sourceData {
    NSMutableArray * responseArray = [NSMutableArray array];
    for (NSString * persona in sourceData) {
        // Cogemos la primera letra
        NSString *firstLetterInName = [persona substringToIndex:1];
        
        // Codificamos y descodificamos para perder los acentos
        NSData *asciiEncoded = [firstLetterInName dataUsingEncoding:NSASCIIStringEncoding
                                               allowLossyConversion:YES];
        NSString *other = [[NSString alloc] initWithData:asciiEncoded
                                                encoding:NSASCIIStringEncoding];
        
        // Sustituimos el primer caracter por el nuevo valor y añdimos al array
        [responseArray addObject:[persona stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:other]];
    }
    return responseArray;
}

- (NSMutableArray *) getFirstLettersInArray:(NSArray *)categoryArray {
    NSMutableArray *indexElements = [NSMutableArray array];
    for (NSString *persona in categoryArray){
        NSString *firstLetterInName = [persona substringToIndex:1];
        NSCharacterSet *notAllowed = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
        NSRange range = [firstLetterInName rangeOfCharacterFromSet:notAllowed];
        
        if (![indexElements containsObject:firstLetterInName] && range.location == NSNotFound ) {
            [indexElements addObject:firstLetterInName];
        }
    }
    return indexElements;
}

@end
