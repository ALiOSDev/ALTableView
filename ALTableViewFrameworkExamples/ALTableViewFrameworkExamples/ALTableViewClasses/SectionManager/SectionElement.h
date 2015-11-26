//
//  SectionElement.h
//  ALTableViewFramework
//
//  Created by lorenzo villarroel perez on 6/11/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define PARAM_SECTIONELEMENT_SECTION_TITLE_INDEX @"sectionTitleIndex"
#define PARAM_SECTIONELEMENT_VIEW_HEADER @"viewHeader"
#define PARAM_SECTIONELEMENT_VIEW_FOOTER @"viewFooter"
#define PARAM_SECTIONELEMENT_HEIGHT_HEADER @"heightHeader"
#define PARAM_SECTIONELEMENT_HEIGHT_FOOTER @"heightFooter"
#define PARAM_SECTIONELEMENT_CELL_OBJECTS @"cellObjects"
#define PARAM_SECTIONELEMENT_IS_EXPANDABLE @"isExpandable"

@protocol SectionHeaderViewDelegate;

@class RowElement;
@interface SectionElement : NSObject

@property (strong, nonatomic) id<SectionHeaderViewDelegate> delegate;

+ (instancetype)sectionElementWithParams:(NSMutableDictionary *) dic;
- (instancetype)initWithParams:(NSMutableDictionary *) dic;

+ (instancetype)sectionElementWithSectionTitleIndex:(NSString *) titleIndex viewHeader:(UIView *) viewHeader viewFooter:(UIView *) viewFooter heightHeader:(NSNumber *) heightHeader heightFooter:(NSNumber *) heightFooter cellObjects:(NSMutableArray *) cellObjects isExpandable: (BOOL) isExpandable;
- (instancetype)initWithSectionTitleIndex:(NSString *) titleIndex viewHeader:(UIView *) viewHeader viewFooter:(UIView *) viewFooter heightHeader:(NSNumber *) heightHeader heightFooter:(NSNumber *) heightFooter cellObjects:(NSMutableArray *) cellObjects isExpandable: (BOOL) isExpandable;

-(UIView *) getHeader;
-(UIView *) getFooter;

-(CGFloat) getHeaderHeight;
-(CGFloat) getFooterHeight;

-(NSInteger) getNumberOfRows;
-(NSInteger) getTotalNumberOfRows;
-(RowElement *) getRowAtPosition:(NSInteger) position;
-(CGFloat) getRowHeightAtPosition:(NSInteger) position;

-(NSString *) getSectionTitleIndex;

//Insert methods
-(void) insertRowElement: (RowElement *) rowElement AtIndex: (NSInteger)index;
-(void) insertRowElements: (NSMutableArray *) rowElements AtIndex: (NSInteger)index;
//Delete methods
-(void) deleteRowElementAtIndex: (NSInteger)index;
-(void) deleteRowElements: (NSInteger) numberOfRowElements AtIndex: (NSInteger)index;
//Replacement methods
-(void) replaceRowElementAtIndex: (NSInteger) index WithRowElement: (RowElement *) rowElement;
//Open and close section methods
-(void) setUpHeaderRecognizer;



@end

@protocol SectionHeaderViewDelegate <NSObject>

@optional
- (void)sectionHeaderView:(SectionElement *)sectionElement sectionOpened:(NSInteger)section;
- (void)sectionHeaderView:(SectionElement *)sectionElement sectionClosed:(NSInteger)section;

@end
