//
//  RowElement.m
//  ALTableViewFramework
//
//  Created by Abimael Barea Puyana on 6/11/15.
//
//

#import "RowElement.h"
#import "ALTableViewConstants.h"
#import <objc/runtime.h>

@interface RowElement ()

@property (strong, nonatomic) Class className;
@property (strong, nonatomic) NSString * cellIdentifier;
@property (strong, nonatomic) id object;

@property (strong, nonatomic) CellPressedHandler cellPressedHandler;
@property (strong, nonatomic) CellCreatedHandler cellCreatedHandler;
@property (strong, nonatomic) CellDeselectedHandler cellDeselectedHandler;

@property(assign, nonatomic) UITableViewCellStyle cellStyle;

@end

@implementation RowElement


#pragma mark - Constructor

+ (instancetype)rowElementWithParams:(NSMutableDictionary *) dic {
    return [[self alloc] initWithParams:dic];
}

- (instancetype)initWithParams:(NSMutableDictionary *) dic {
    self = [super init];
    if (self) {
        self.className = dic[PARAM_ROWELEMENT_CLASS];
        self.object = dic[PARAM_ROWELEMENT_OBJECT];
        self.heightCell = dic[PARAM_ROWELEMENT_HEIGHTCELL];
        self.cellIdentifier = dic[PARAM_ROWELEMENT_CELLIDENTIFIER];
        self.cellStyle = UITableViewCellStyleDefault;
        
        [self checkClassAttributes];
    }
    return self;
}

+ (instancetype)rowElementWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier {
    return [[self alloc] initWithClassName:className object:object heightCell:heightCell cellIdentifier:cellIdentifier];
}

- (instancetype)initWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier{
    self = [super init];
    if (self) {
        self.className = className;
        self.object = object;
        self.heightCell = heightCell;
        self.cellIdentifier = cellIdentifier;
        self.cellStyle = UITableViewCellStyleDefault;
        
        [self checkClassAttributes];
    }
    return self;
}

+ (instancetype)rowElementWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier CellStyle: (UITableViewCellStyle) cellStyle CellPressedHandler: (CellPressedHandler) cellPressedHandler CellCreatedHandler: (CellCreatedHandler) cellCreatedHandler CellDeselectedHandler: (CellDeselectedHandler) cellDeselectedHandler {
    return [[self alloc] initWithClassName:className object:object heightCell:heightCell cellIdentifier:cellIdentifier CellStyle:cellStyle CellPressedHandler:cellPressedHandler CellCreatedHandler:cellCreatedHandler CellDeselectedHandler:cellDeselectedHandler ];
}

- (instancetype)initWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier CellStyle: (UITableViewCellStyle) cellStyle CellPressedHandler: (CellPressedHandler) cellPressedHandler CellCreatedHandler: (CellCreatedHandler) cellCreatedHandler CellDeselectedHandler: (CellDeselectedHandler) cellDeselectedHandler{
    self = [self initWithClassName:className object:object heightCell:heightCell cellIdentifier:cellIdentifier];
    if (self) {
        self.cellPressedHandler = cellPressedHandler;
        self.cellCreatedHandler = cellCreatedHandler;
        self.cellDeselectedHandler = cellDeselectedHandler;
        self.cellStyle = cellStyle;
    }
    return self;
}


#pragma mark - Private Methods

-(void) checkClassAttributes {
    if (!self.className) {
//        NSLog(@"%@ClassName param index is null", warningString);
        self.className = nil;
    }
    if (!self.object) {
//        NSLog(@"%@Object param is null", warningString);
        self.object = nil;
    }
    if (!self.heightCell) {
//        NSLog(@"%@HeightCell param is null", warningString);
        self.heightCell = [NSNumber numberWithInt:44];
    }
    if (!self.cellIdentifier) {
//        NSLog(@"%@CellIdentifier param is null", warningString);
        self.cellIdentifier = nil;
    }
}

#pragma mark - Getters

-(void) configureCell: (id) object {}

-(UITableViewCell *) getCellFromTableView:(UITableView *) tableView {
    NSString *cellIdentifier = self.cellIdentifier;
    
    if (!self.cellIdentifier) {
        cellIdentifier = NSStringFromClass(self.className);
        if ([cellIdentifier componentsSeparatedByString:@"."].count > 1) {
            NSArray * tempArray = [cellIdentifier componentsSeparatedByString:@"."];
            cellIdentifier = [tempArray lastObject];
            
        }
    }
    
    id cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[self.className alloc] initWithStyle:self.cellStyle reuseIdentifier:cellIdentifier];
    }
    
    object_setClass(cell, self.className);
    
    // Call method or block for config
    if ([cell respondsToSelector:@selector(configureCell:)]) {
        [cell configureCell:self.object];
    }
    
    if (self.cellCreatedHandler) {
       self.cellCreatedHandler(self.object, cell);
    }
    
    return cell;
}

-(NSObject *) getObject {
    return self.object;
}

-(CGFloat) getHeightCell {
    return [self.heightCell floatValue];
}

#pragma mark - Handlers

-(void) executeAction: (UIViewController *) viewController {}

-(void) rowElementPressed: (UIViewController *) viewController Cell: (id) cell {
    // Call method or block for action
    if ([cell respondsToSelector:@selector(executeAction:)]) {
        [cell executeAction:viewController];
    }

    if (self.cellPressedHandler) {
        self.cellPressedHandler(viewController, cell);
    }
}

-(void) cellDeselected {}

-(void) rowElementDeselected: (id) cell {
    // Call method or block for deselection
    if ([cell respondsToSelector:@selector(cellDeselected)]) {
        [cell cellDeselected];
    }
    
    if (self.cellDeselectedHandler) {
        self.cellDeselectedHandler(cell);
    }
}

@end
