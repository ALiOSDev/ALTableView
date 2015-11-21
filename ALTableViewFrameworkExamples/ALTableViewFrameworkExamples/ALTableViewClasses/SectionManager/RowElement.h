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

@interface RowElement : NSObject

+ (instancetype)rowElementWithParams:(NSMutableDictionary *) dic;
- (instancetype)initWithParams:(NSMutableDictionary *) dic;

+ (instancetype)rowElementWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier;
- (instancetype)initWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier;

-(UITableViewCell *) getCellFromTableView:(UITableView *) tableView;
-(id) getObject;
-(CGFloat) getHeightCell;

@end
