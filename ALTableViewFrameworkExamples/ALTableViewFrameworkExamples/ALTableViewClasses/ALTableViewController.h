//
//  ALTableViewController.h
//  ALTableViewFramework
//
//  Created by Abimael Barea Puyana on 6/11/15.
//
//

#import <UIKit/UIKit.h>
#import "SectionManager.h"

#define PARAM_ALTABLEVIEWCONTROLLER_FRAME @"frame"
#define PARAM_ALTABLEVIEWCONTROLLER_STYLE @"style"
#define PARAM_ALTABLEVIEWCONTROLLER_BACKGROUND_VIEW @"backgroundView"
#define PARAM_ALTABLEVIEWCONTROLLER_BACKGROUND_COLOR @"backgroundColor"
#define PARAM_ALTABLEVIEWCONTROLLER_SECTIONS @"sections"
#define PARAM_ALTABLEVIEWCONTROLLER_MODE_SECTIONS_EXPANABLE @"modeSectionsExpandable"
#define PARAM_ALTABLEVIEWCONTROLLER_MODE_SECTIONS_INDEX_TITLE @"modeSectionsIndexTitles"

@protocol ALTableViewProtocol <NSObject>

@optional
-(void) tableViewDidReachEnd;

@end

@class RowElement, SectionElement;
@interface ALTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, SectionManagerProtocol>

//@property (assign, nonatomic) BOOL modeSectionsExpandable;
@property (assign, nonatomic) BOOL modeSectionsIndexTitles;
@property (assign, nonatomic) BOOL modeMoveCells;

@property (weak, nonatomic) id<ALTableViewProtocol> additionalDelegate;

//Constructors
+ (instancetype)tableViewControllerWithFrame:(CGRect)frame style:(UITableViewStyle)style backgroundView: (UIView*) backgroundView backgroundColor: (UIColor*) backgroundColor sections:(NSArray*)sections;
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style backgroundView: (UIView*) backgroundView backgroundColor: (UIColor*) backgroundColor sections:(NSArray*)sections;

//Register Cells
-(void) registerClass: (Class) classToRegister CellIdentifier: (NSString *) cellIdentifier;

//Add row methods
-(BOOL) insertRowElement:(RowElement *) rowElement AtIndexPath: (NSIndexPath *) indexPath;
-(BOOL) insertRowElement:(RowElement *) rowElement AtSection: (NSInteger) section Row: (NSInteger) row;
-(BOOL) insertRowElements:(NSMutableArray *) rowElements AtIndexPath: (NSIndexPath *) indexPath;
-(BOOL) insertRowElements:(NSMutableArray *) rowElements AtSection: (NSInteger) section Row: (NSInteger) row;
-(BOOL) insertRowElement:(RowElement *) rowElement AtTheBeginingOfSection: (NSInteger) section;
-(BOOL) insertRowElements:(NSMutableArray *) rowElements AtTheBeginingOfSection: (NSInteger) section;
-(BOOL) insertRowElement:(RowElement *) rowElement AtTheEndOfSection: (NSInteger) section;
-(BOOL) insertRowElements:(NSMutableArray *) rowElements AtTheEndOfSection: (NSInteger) section;

//Remove row methods
-(BOOL) deleteRowElementAtIndexPath: (NSIndexPath *) indexPath;
-(BOOL) deleteRowElementAtSection: (NSInteger) section Row: (NSInteger) row;
-(BOOL) deleteRowElements: (NSInteger) numberOfElements AtIndexPath: (NSIndexPath *) indexPath;
-(BOOL) deleteRowElements: (NSInteger) numberOfElements AtSection: (NSInteger) section Row: (NSInteger) row;
-(BOOL) deleteRowElementAtTheBeginingOfSection: (NSInteger) section;
-(BOOL) deleteRowElements:(NSInteger) numberOfElements AtTheBeginingOfSection: (NSInteger) section;
-(BOOL) deleteRowElementAtTheEndOfSection: (NSInteger) section;
-(BOOL) deleteRowElements:(NSInteger) numberOfElements AtTheEndOfSection: (NSInteger) section;

//Replace row methods
-(BOOL) replaceRowElementAtIndexPath: (NSIndexPath *) indexPath WithRowElement: (RowElement *) rowElement;
-(BOOL) replaceRowElementAtSection: (NSInteger) section Row: (NSInteger) row WithRowElement: (RowElement *) rowElement;

//Add section methods
-(BOOL) insertSectionAtBegining:(SectionElement *) section;
-(BOOL) insertSectionAtEnd:(SectionElement *) section;
-(BOOL) insertSection:(SectionElement *) section AtIndexPath: (NSIndexPath *) indexPath;
-(BOOL) insertSection:(SectionElement *) section AtPosition:(NSInteger) position;

//Replace section methods
-(BOOL) reloadSection:(SectionElement *) section AtIndexPath: (NSIndexPath *) indexPath;
-(BOOL) reloadSection:(SectionElement *) section AtPosition:(NSInteger) position;
-(void) replaceAllSections:(NSMutableArray *) sections;

//Remove section methods
-(BOOL) removeSectionAtIndexPath: (NSIndexPath *) indexPath;
-(BOOL) removeSectionAtPosition:(NSInteger) position;

//Get section methods
-(NSMutableArray *) getAllSections;

@end
