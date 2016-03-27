//
//  RowElement.h
//  ALTableViewFramework
//
//  Created by Abimael Barea Puyana on 6/11/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define PARAM_ROWELEMENT_CLASS @"class"
#define PARAM_ROWELEMENT_CELLIDENTIFIER @"cellIdentifier"
#define PARAM_ROWELEMENT_OBJECT @"object"
#define PARAM_ROWELEMENT_HEIGHTCELL @"heightCell"
#define PARAM_ROWELEMENT_CELL_STYLE @"cellStyle"
#define PARAM_ROWELEMENT_CELL_PRESSED @"cellPressedHandler"
#define PARAM_ROWELEMENT_CELL_CREATED @"cellCreatedHandler"
#define PARAM_ROWELEMENT_CELL_DESELECT @"cellDeselectedHandler"


//Definition of possible blocks
typedef void (^CellPressedHandler)(UIViewController * viewController, id cell);
typedef void (^CellCreatedHandler)(id object, id cell);
typedef void (^CellDeselectedHandler)(id cell);

@interface RowElement : NSObject <UITextViewDelegate>

@property (assign, nonatomic) BOOL estimateHeightMode;
@property (strong, nonatomic) NSNumber * heightCell;

//Constructors
+ (instancetype)rowElementWithParams:(NSDictionary *) dic;
- (instancetype)initWithParams:(NSDictionary *) dic;

+ (instancetype)rowElementWithParams:(NSDictionary *) dic CellPressedHandler: (CellPressedHandler) cellPressedHandler CellCreatedHandler: (CellCreatedHandler) cellCreatedHandler CellDeselectedHandler: (CellDeselectedHandler) cellDeselectedHandler;
- (instancetype)initWithParams:(NSDictionary *) dic CellPressedHandler: (CellPressedHandler) cellPressedHandler CellCreatedHandler: (CellCreatedHandler) cellCreatedHandler CellDeselectedHandler: (CellDeselectedHandler) cellDeselectedHandler;

+ (instancetype)rowElementWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell;
- (instancetype)initWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell;

+ (instancetype)rowElementWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier;
- (instancetype)initWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier;

+ (instancetype)rowElementWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier CellStyle: (UITableViewCellStyle) cellStyle CellPressedHandler: (CellPressedHandler) cellPressedHandler CellCreatedHandler: (CellCreatedHandler) cellCreatedHandler CellDeselectedHandler: (CellDeselectedHandler) cellDeselectedHandler;
- (instancetype)initWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier CellStyle: (UITableViewCellStyle) cellStyle CellPressedHandler: (CellPressedHandler) cellPressedHandler CellCreatedHandler: (CellCreatedHandler) cellCreatedHandler CellDeselectedHandler: (CellDeselectedHandler) cellDeselectedHandler;


//Methods
-(UITableViewCell *) getCellFromTableView:(UITableView *) tableView;
-(id) getObject;
-(CGFloat) getHeightCell;

-(void) rowElementPressed: (UIViewController *) viewController Cell: (id) cell;
-(void) rowElementDeselected: (id) cell;

-(NSDictionary *) retreiveElements;

@end
