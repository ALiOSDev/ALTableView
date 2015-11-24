//
//  SectionManager.h
//  ALTableViewFramework
//
//  Created by lorenzo villarroel perez on 6/11/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SectionElement.h"

@protocol SectionManagerProtocol <NSObject>

@optional
-(void) sectionOpenedAtIndex: (NSInteger) index NumberOfElements: (NSInteger) numberOfElements;
-(void) sectionClosedAtIndex: (NSInteger) index NumberOfElements: (NSInteger) numberOfElements;

@end

@class RowElement, SectionElement;
@interface SectionManager : NSObject <SectionHeaderViewDelegate>

@property (strong, nonatomic) id<SectionManagerProtocol> delegate;

+ (instancetype) sectionManagerWithSections:(NSArray *) sectionsElements;
- (instancetype)initWithSections:(NSArray *) sectionsElements;

-(NSInteger) getNumberOfSections;
-(NSInteger) getNumberOfRows:(NSInteger) section;

-(UITableViewCell *) getCellFromTableView:(UITableView *) tableView IndexPath:(NSIndexPath *) indexPath;
-(UITableViewCell *) getCellFromTableView:(UITableView *) tableView Section:(NSInteger) section Row: (NSInteger) row;

-(UIView *) getSectionHeaderFromIndexPath:(NSIndexPath *) indexPath;
-(UIView *) getSectionHeaderFromSection:(NSInteger) section;
-(UIView *) getSectionFooterFromIndexPath:(NSIndexPath *) indexPath;
-(UIView *) getSectionFooterFromSection:(NSInteger) section;

-(CGFloat) getCellHeightFromIndexPath:(NSIndexPath *) indexPath;
-(CGFloat) getCellHeightFromSection:(NSInteger) section Row: (NSInteger) row;

-(CGFloat) getSectionHeaderHeightFromIndexPath:(NSIndexPath *) indexPath;
-(CGFloat) getSectionHeaderHeightFromSection:(NSInteger) section;

-(CGFloat) getSectionFooterHeightFromIndexPath:(NSIndexPath *) indexPath;
-(CGFloat) getSectionFooterHeightFromSection:(NSInteger) section;

//Get row element
-(RowElement *) getRowElementAtIndexPath:(NSIndexPath *) indexPath;
-(RowElement *) getRowElementAtSection: (NSInteger) section Row: (NSInteger) row;

//Insert methods
-(void) insertRowElement: (RowElement *) rowElement AtSection: (NSInteger) section Row: (NSInteger) row;
-(void) insertRowElements: (NSMutableArray *) rowElements AtSection: (NSInteger) section Row: (NSInteger) row;

//Delete methods
-(void) deleteRowElementAtSection: (NSInteger) section Row: (NSInteger) row;
-(void) deleteRowElements: (NSInteger) numberOfRowElements AtSection: (NSInteger) section Row: (NSInteger) row;

//Replace methods
-(void) replaceRowElementAtSection: (NSInteger) section Row: (NSInteger) row WithRowElement: (RowElement *) rowElement;

//Manage sections
-(void) insertSection:(SectionElement *) section AtPosition:(NSInteger) position;
-(void) replaceSection:(SectionElement *) section AtPosition:(NSInteger) position;
-(void) removeSectionAtPosition:(NSInteger) position;
-(void) replaceAllSections:(NSMutableArray *) sections;
-(NSMutableArray *) getAllSections;

//Managing opening and closing of sections
-(void) setUpHandlerForSectionAtIndex: (NSInteger) index;

-(NSMutableArray *) getSectionIndexTitles;

-(NSIndexPath *) getNextIndexPathToIndexPath: (NSIndexPath *) indexPath;
-(NSIndexPath *) getPreviousIndexPathToIndexPath: (NSIndexPath *) indexPath;

@end

