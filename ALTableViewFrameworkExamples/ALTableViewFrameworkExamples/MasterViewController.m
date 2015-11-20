//
//  MasterViewController.m
//  ALTableViewFrameworkExamples
//
//  Created by Abimael Barea Puyana on 20/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ButtonLabelTableViewCell.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

    self.modeSectionsIndexTitles = YES;
    self.modeSectionsExpandable = YES;
    self.modeMoveCells = YES;
    [self registerCells];
    [self reloadAllSections:[self createElements]];

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
    [self registerClass:[ButtonLabelTableViewCell class] CellIdentifier:@"ButtonLabelTableViewCell"];
}


// Professional Example

- (NSMutableArray *) createElements {
    NSMutableArray *sourceData = [NSMutableArray arrayWithObjects:@"Aadi", @"Abimael", @"Antonio", @"Alberto", @"Antón", @"Ainhoa", @"Alejandro", @"Alvaro", @"Bruno", @"Bárcenas", @"Lorenzo", @"Lidia", @"Lucas", @"Lola", @"Maria", @"Mario", @"Marcos", @"Matías", nil];
    
    sourceData = [self replaceFirstCharAccent:sourceData];
    NSMutableArray * firstLetters = [self getFirstLettersInArray:sourceData];
    
    // Creamos las secciones
    NSMutableArray * sections = [NSMutableArray array];
    
    for (NSString *firsLetterTitle in firstLetters) {
        NSString * sectionTitleIndex = firsLetterTitle;
        NSMutableArray * rowElements = [NSMutableArray array];
        
        for (NSString * element in sourceData) {
            if ([firsLetterTitle isEqualToString:[element substringToIndex:1]]) {
                [rowElements addObject:[RowElement rowElementWithClassName:[ButtonLabelTableViewCell class] object:nil heightCell:[NSNumber numberWithInt:44] cellIdentifier:nil]];
            }
        }
        
        UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        labelTitle.text = sectionTitleIndex;
        labelTitle.backgroundColor = [UIColor greenColor];
        [sections addObject:[SectionElement sectionElementWithSectionTitleIndex:sectionTitleIndex viewHeader:labelTitle viewFooter:nil heightHeader:@40 heightFooter:nil cellObjects:rowElements]];
    }
    
    return sections;
}

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
