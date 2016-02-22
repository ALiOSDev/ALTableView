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
@property (strong, nonatomic) CellRetrieveElementsHandler cellRetrieveElementsHandler;

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

+ (instancetype)rowElementWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier CellStyle: (UITableViewCellStyle) cellStyle CellPressedHandler: (CellPressedHandler) cellPressedHandler CellCreatedHandler: (CellCreatedHandler) cellCreatedHandler CellDeselectedHandler: (CellDeselectedHandler) cellDeselectedHandler CellRetrieveElementsHandler:(CellRetrieveElementsHandler) cellRetrieveElementsHandler{
    return [[self alloc] initWithClassName:className object:object heightCell:heightCell cellIdentifier:cellIdentifier CellStyle:cellStyle CellPressedHandler:cellPressedHandler CellCreatedHandler:cellCreatedHandler CellDeselectedHandler:cellDeselectedHandler ];
}

- (instancetype)initWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell cellIdentifier:(NSString *) cellIdentifier CellStyle: (UITableViewCellStyle) cellStyle CellPressedHandler: (CellPressedHandler) cellPressedHandler CellCreatedHandler: (CellCreatedHandler) cellCreatedHandler CellDeselectedHandler: (CellDeselectedHandler) cellDeselectedHandler CellRetrieveElementsHandler:(CellRetrieveElementsHandler) cellRetrieveElementsHandler{
    self = [self initWithClassName:className object:object heightCell:heightCell cellIdentifier:cellIdentifier];
    if (self) {
        self.cellPressedHandler = cellPressedHandler;
        self.cellCreatedHandler = cellCreatedHandler;
        self.cellDeselectedHandler = cellDeselectedHandler;
        self.cellRetrieveElementsHandler = cellRetrieveElementsHandler;
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

-(NSDictionary *) retreiveElementsFromCell: (id) cell {
    return [NSDictionary dictionary];
}

-(NSDictionary *) retreiveElements: (id) cell {
    if ([cell respondsToSelector:@selector(retreiveElementsFromCell:)]) {
        return [[NSDictionary alloc] initWithDictionary:[cell retreiveElementsFromCell: cell]];
    }
    
    if (self.cellRetrieveElementsHandler) {
        return self.cellRetrieveElementsHandler(cell);
    }
    
    return [self getFieldsValues:cell];
}


#pragma mark - Auxiliar: retrieve values for elements in cell

- (NSDictionary *) getFieldsValues:(NSObject *) object  {
    NSDictionary * properties = [self getPropertiesDictionaryRepresentation:object];
    
    NSMutableDictionary * results = [NSMutableDictionary dictionary];
    for (NSString *aKey in [properties allKeys]) {
        NSDictionary *aValue = [properties valueForKey:aKey];
        [results setValue:[self processUIElement:(UIView *) aValue] forKey:aKey];
        //NSLog(@"Key : %@", aKey);
        //NSLog(@"Value : %@", aValue);
    }
    
    return results;
}

- (NSObject *) processUIElement:(UIView *) view {
    if ([view isKindOfClass:UILabel.class]) {
        return ((UILabel *) view).text;
    } else if ([view isKindOfClass:UITextField.class]) {
        return ((UITextField *) view).text;
    } else if ([view isKindOfClass:UISwitch.class]) {
        return ((UISwitch *) view).isOn ? @1 : @0;
    }
    
    return nil;
}

- (NSDictionary *) getPropertiesDictionaryRepresentation: (NSObject *) object {
    unsigned int count = 0;
    // Get a list of all properties in the class.
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:count];
    for (int i = 0; i < count; i++) {
        @try {
            NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
            NSString *value = [object valueForKey:key];
            
            // Only add to the NSDictionary if it's not nil.
            if (value) [dictionary setObject:value forKey:key];
        }@catch (NSException *exception) {
            continue;
        }
    }
    
    free(properties);
    return dictionary;
}

@end
