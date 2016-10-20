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

@property (assign, nonatomic) UITableViewCellStyle cellStyle;

@property (strong, nonatomic) NSDictionary * properties;
@property (strong, nonatomic) NSMutableDictionary * valuesPropertiesCell;

@end

@implementation RowElement


#pragma mark - Constructor

+ (instancetype)rowElementWithParams:(NSDictionary *) dic {
    return [[self alloc] initWithParams:dic];
}

- (instancetype)initWithParams:(NSDictionary *) dic {
    self = [super init];
    if (self) {
        self.className = dic[PARAM_ROWELEMENT_CLASS];
        self.object = dic[PARAM_ROWELEMENT_OBJECT];
        self.heightCell = dic[PARAM_ROWELEMENT_HEIGHTCELL];
        self.cellIdentifier = dic[PARAM_ROWELEMENT_CELLIDENTIFIER];
        self.cellStyle = [dic[PARAM_ROWELEMENT_CELL_STYLE] longLongValue];
        self.cellPressedHandler = dic[PARAM_ROWELEMENT_CELL_PRESSED];
        self.cellCreatedHandler = dic[PARAM_ROWELEMENT_CELL_CREATED];
        self.cellDeselectedHandler = dic[PARAM_ROWELEMENT_CELL_DESELECT];
        
        [self checkClassAttributes];
    }
    return self;
}

+ (instancetype)rowElementWithParams:(NSDictionary *) dic CellPressedHandler: (CellPressedHandler) cellPressedHandler CellCreatedHandler: (CellCreatedHandler) cellCreatedHandler CellDeselectedHandler: (CellDeselectedHandler) cellDeselectedHandler {
    return [[self alloc] initWithParams:dic CellPressedHandler:cellPressedHandler CellCreatedHandler:cellCreatedHandler CellDeselectedHandler:cellDeselectedHandler];
}

- (instancetype)initWithParams:(NSDictionary *) dic CellPressedHandler: (CellPressedHandler) cellPressedHandler CellCreatedHandler: (CellCreatedHandler) cellCreatedHandler CellDeselectedHandler: (CellDeselectedHandler) cellDeselectedHandler {
    self = [self initWithParams:dic];
    if (self) {
        self.cellPressedHandler = cellPressedHandler;
        self.cellCreatedHandler = cellCreatedHandler;
        self.cellDeselectedHandler = cellDeselectedHandler;
    }
    return self;
}

+ (instancetype)rowElementWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell {
    return [[self alloc] initWithClassName:className object:object heightCell:heightCell];
}

- (instancetype)initWithClassName:(Class) className object:(id) object heightCell:(NSNumber *) heightCell {
    self = [super init];
    if (self) {
        self.className = className;
        self.object = object;
        self.heightCell = heightCell;
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
        self.className = nil;
    }
    if (!self.object) {
        self.object = nil;
    }
    if (!self.heightCell) {
        self.heightCell = [NSNumber numberWithInt:44];
    }
    if (!self.cellIdentifier) {
        self.cellIdentifier = nil;
    }
    if (!self.cellStyle) {
        self.cellStyle = UITableViewCellStyleDefault;
    }
    if (!self.cellPressedHandler) {
        self.cellPressedHandler = nil;
    }
    if (!self.cellCreatedHandler) {
        self.cellCreatedHandler = nil;
    }
    if (!self.cellDeselectedHandler) {
        self.cellDeselectedHandler = nil;
    }
}


#pragma mark - Getters

-(void) cellCreated: (id) object {}

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
    if ([cell respondsToSelector:@selector(cellCreated:)]) {
        [cell cellCreated:self.object];
    }
    
    if (self.cellCreatedHandler) {
       self.cellCreatedHandler(self.object, cell);
    }
    
    [self analyzeCell:cell];
    return cell;
}

-(NSObject *) getObject {
    return self.object;
}

-(CGFloat) getHeightCell {
    return [self.heightCell floatValue];
}


#pragma mark - Handlers

-(void) cellPressed: (UIViewController *) viewController {}

-(void) rowElementPressed: (UIViewController *) viewController Cell: (id) cell {
    // Call method or block for action
    if ([cell respondsToSelector:@selector(cellPressed:)]) {
        [cell cellPressed:viewController];
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

-(NSDictionary *) retreiveElements {
    return self.valuesPropertiesCell;
}


#pragma mark - Auxiliar: retrieve values for elements in cell

-(void) analyzeCell:(UITableViewCell *) cell {
    self.properties = [self getPropertiesDictionaryRepresentation:cell];
    
    self.valuesPropertiesCell = [NSMutableDictionary dictionary];
    for (NSString *aKey in [self.properties allKeys]) {
        NSObject *aValue = [self.properties valueForKey:aKey];
        [self processUIElement:(UIView *) aValue key:aKey];
    }
}

- (void) processUIElement:(UIView *) view key:(NSString *) aKey {
    if ([view isKindOfClass:UILabel.class]) {
        [self.valuesPropertiesCell setValue:((UILabel *) view).text forKey:aKey];
    } else if ([view isKindOfClass:UITextField.class]) {
        [self.valuesPropertiesCell setValue:((UITextField *) view).text forKey:aKey];
        [((UITextField *) view) addTarget:self
                                   action:@selector(textFieldDidChange:)
                         forControlEvents:UIControlEventEditingChanged];
    } else if ([view isKindOfClass:UITextView.class]) {
        [self.valuesPropertiesCell setValue:((UITextView *) view).text forKey:aKey];
        [((UITextView *) view) setDelegate:self];
    } else if ([view isKindOfClass:UISwitch.class]) {
        [self.valuesPropertiesCell setValue:((UISwitch *) view).isOn ? @1 : @0  forKey:aKey];
        [((UISwitch *) view) addTarget:self
                             action:@selector(switchStateChanges:)
                   forControlEvents:UIControlEventValueChanged];
    }
}

-(void) textFieldDidChange:(UITextField *) textField {
    for (NSString *aKey in [self.properties allKeys]) {
        NSObject *aValue = [self.properties valueForKey:aKey];
        if ([textField isEqual:aValue]) {
            [self.valuesPropertiesCell setValue:textField.text forKey:aKey];
            break;
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    for (NSString *aKey in [self.properties allKeys]) {
        NSObject *aValue = [self.properties valueForKey:aKey];
        if ([textView isEqual:aValue]) {
            [self.valuesPropertiesCell setValue:textView.text forKey:aKey];
            break;
        }
    }
}

-(void) switchStateChanges:(UISwitch *) switchElement {
    for (NSString *aKey in [self.properties allKeys]) {
        NSObject *aValue = [self.properties valueForKey:aKey];
        if ([switchElement isEqual:aValue]) {
            [self.valuesPropertiesCell setValue:switchElement.isOn ? @1 : @0 forKey:aKey];
            break;
        }
    }
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
