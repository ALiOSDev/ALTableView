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

typedef void (^CellPressedHandler)(UIViewController * viewController, id cell);
typedef void (^CellCreatedHandler)(id object, id cell);
typedef void (^CellDeselectedHandler)(id cell);

@interface RowElement : NSObject

@property (strong, nonatomic) NSNumber * heightCell;

+ (instancetype)rowElementWithParams:(NSMutableDictionary *) dic;
- (instancetype)initWithParams:(NSMutableDictionary *) dic;

+ (instancetype)rowElementWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier;
- (instancetype)initWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier;


+ (instancetype)rowElementWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier CellStyle: (UITableViewCellStyle) cellStyle CellPressedHandler: (CellPressedHandler) cellPressedHandler CellCreatedHandler: (CellCreatedHandler) cellCreatedHandler CellDeselectedHandler: (CellDeselectedHandler) cellDeselectedHandler;
- (instancetype)initWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier CellStyle: (UITableViewCellStyle) cellStyle CellPressedHandler: (CellPressedHandler) cellPressedHandler CellCreatedHandler: (CellCreatedHandler) cellCreatedHandler CellDeselectedHandler: (CellDeselectedHandler) cellDeselectedHandler;

-(UITableViewCell *) getCellFromTableView:(UITableView *) tableView;
-(id) getObject;
-(CGFloat) getHeightCell;

-(void) rowElementPressed: (UIViewController *) viewController Cell: (id) cell;
-(void) rowElementDeselected: (id) cell;

@end
