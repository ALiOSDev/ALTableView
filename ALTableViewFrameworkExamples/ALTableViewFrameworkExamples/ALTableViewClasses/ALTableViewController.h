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
-(BOOL) removeRowElementAtIndexPath: (NSIndexPath *) indexPath;
-(BOOL) removeRowElementAtSection: (NSInteger) section Row: (NSInteger) row;
-(BOOL) removeRowElements: (NSInteger) numberOfElements AtIndexPath: (NSIndexPath *) indexPath;
-(BOOL) removeRowElements: (NSInteger) numberOfElements AtSection: (NSInteger) section Row: (NSInteger) row;
-(BOOL) removeRowElementAtTheBeginingOfSection: (NSInteger) section;
-(BOOL) removeRowElements:(NSInteger) numberOfElements AtTheBeginingOfSection: (NSInteger) section;
-(BOOL) removeRowElementAtTheEndOfSection: (NSInteger) section;
-(BOOL) removeRowElements:(NSInteger) numberOfElements AtTheEndOfSection: (NSInteger) section;

//Replace row methods
-(BOOL) replaceRowElementAtIndexPath: (NSIndexPath *) indexPath WithRowElement: (RowElement *) rowElement;
-(BOOL) replaceRowElementAtSection: (NSInteger) section Row: (NSInteger) row WithRowElement: (RowElement *) rowElement;

//Add section methods
-(BOOL) insertSectionElementAtTheBeginingOfTableView:(SectionElement *) section;
-(BOOL) insertSectionElementAtTheEndOfTableView:(SectionElement *) section;
-(BOOL) insertSectionElement:(SectionElement *) section AtIndexPath: (NSIndexPath *) indexPath;
-(BOOL) insertSectionElement:(SectionElement *) section AtSection:(NSInteger) position;

//Replace section methods
-(void) replaceAllSectionElements:(NSMutableArray *) sections;
-(BOOL) replaceSectionElementAtIndexPath: (NSIndexPath *) indexPath WithSectionElement: (SectionElement *) sectionElement;
-(BOOL) replaceSectionElementAtSection: (NSInteger) section WithSectionElement: (SectionElement *) sectionElement;

//Remove section methods
-(BOOL) removeSectionElementAtIndexPath: (NSIndexPath *) indexPath;
-(BOOL) removeSectionElementAtSection:(NSInteger) section;

//Get section methods
-(NSMutableArray *) getAllSectionElements;

@end