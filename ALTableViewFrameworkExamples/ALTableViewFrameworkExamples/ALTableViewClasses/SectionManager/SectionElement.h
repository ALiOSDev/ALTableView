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
#define PARAM_SECTIONELEMENT_SOUCE_DATA @"sourceData"
#define PARAM_SECTIONELEMENT_CLASS_FOR_ROW @"classForRow"

@protocol SectionHeaderViewDelegate;

@class RowElement;
@interface SectionElement : NSObject

@property (weak, nonatomic) id<SectionHeaderViewDelegate> delegate;

+ (instancetype)sectionElementWithParams:(NSDictionary *) dic;
- (instancetype)initWithParams:(NSDictionary *) dic;

+ (instancetype)sectionElementWithSectionTitleIndex:(NSString *) titleIndex viewHeader:(UIView *) viewHeader viewFooter:(UIView *) viewFooter heightHeader:(NSNumber *) heightHeader heightFooter:(NSNumber *) heightFooter cellObjects:(NSMutableArray *) cellObjects isExpandable: (BOOL) isExpandable;
- (instancetype)initWithSectionTitleIndex:(NSString *) titleIndex viewHeader:(UIView *) viewHeader viewFooter:(UIView *) viewFooter heightHeader:(NSNumber *) heightHeader heightFooter:(NSNumber *) heightFooter cellObjects:(NSMutableArray *) cellObjects isExpandable: (BOOL) isExpandable;

+ (instancetype)sectionElementWithSectionTitleIndex:(NSString *) titleIndex viewHeader:(UIView *) viewHeader viewFooter:(UIView *) viewFooter heightHeader:(NSNumber *) heightHeader heightFooter:(NSNumber *) heightFooter sourceData:(NSMutableArray *) sourceData classForRow:(Class) className isExpandable: (BOOL) isExpandable;

- (instancetype)initWithSectionTitleIndex:(NSString *) titleIndex viewHeader:(UIView *) viewHeader viewFooter:(UIView *) viewFooter heightHeader:(NSNumber *) heightHeader heightFooter:(NSNumber *) heightFooter sourceData:(NSMutableArray *) sourceData classForRow:(Class) className isExpandable: (BOOL) isExpandable;

-(UIView *) getHeader;
-(UIView *) getFooter;

-(CGFloat) getHeaderHeight;
-(CGFloat) getFooterHeight;

-(NSInteger) getNumberOfRows;
-(NSInteger) getNumberOfRealRows;
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

@end

@protocol SectionHeaderViewDelegate <NSObject>

@optional
- (void)sectionHeaderView:(SectionElement *)sectionElement sectionOpened:(NSInteger)section;
- (void)sectionHeaderView:(SectionElement *)sectionElement sectionClosed:(NSInteger)section;

@end
