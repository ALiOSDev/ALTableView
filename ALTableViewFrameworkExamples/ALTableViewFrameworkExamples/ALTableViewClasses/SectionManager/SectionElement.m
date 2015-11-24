//
//  SectionElement.m
//  ALTableViewFramework
//
//  Created by lorenzo villarroel perez on 6/11/15.
//
//

#import "SectionElement.h"
#import "ALTableViewConstants.h"
#import "RowElement.h"

@interface SectionElement ()

@property (strong, nonatomic) NSString * sectionTitleIndex;

@property (strong, nonatomic) UIView *viewHeader;
@property (strong, nonatomic) UIView *viewFooter;

@property (strong, nonatomic) NSNumber *heightHeader;
@property (strong, nonatomic) NSNumber *heightFooter;

@property (assign, nonatomic) BOOL isOpened;

@property (strong, nonatomic) NSMutableArray<__kindof RowElement *> * cellObjects;

@end

@implementation SectionElement

#pragma mark - Constructor

+ (instancetype)sectionElementWithParams:(NSMutableDictionary *) dic {
    return [[self alloc] initWithParams:dic];
}

- (instancetype)initWithParams:(NSMutableDictionary *) dic {
    self = [super init];
    if (self) {
        self.sectionTitleIndex = dic[PARAM_SECTIONELEMENT_SECTION_TITLE_INDEX];
        self.viewHeader = dic[PARAM_SECTIONELEMENT_VIEW_HEADER];
        self.viewFooter = dic[PARAM_SECTIONELEMENT_VIEW_FOOTER];
        self.heightHeader = dic[PARAM_SECTIONELEMENT_HEIGHT_HEADER];
        self.heightFooter = dic[PARAM_SECTIONELEMENT_HEIGHT_FOOTER];
        self.cellObjects = dic[PARAM_SECTIONELEMENT_CELL_OBJECTS];
        self.isOpened = YES;
        
        [self checkClassAttributes];
    }
    return self;
}

+ (instancetype)sectionElementWithSectionTitleIndex:(NSString *) titleIndex viewHeader:(UIView *) viewHeader viewFooter:(UIView *) viewFooter heightHeader:(NSNumber *) heightHeader heightFooter:(NSNumber *) heightFooter cellObjects:(NSMutableArray *) cellObjects {
    return [[self alloc] initWithSectionTitleIndex:titleIndex viewHeader:viewHeader viewFooter:viewFooter heightHeader:heightHeader heightFooter:heightFooter cellObjects:cellObjects];
}

- (instancetype)initWithSectionTitleIndex:(NSString *) titleIndex viewHeader:(UIView *) viewHeader viewFooter:(UIView *) viewFooter heightHeader:(NSNumber *) heightHeader heightFooter:(NSNumber *) heightFooter cellObjects:(NSMutableArray *) cellObjects {
    self = [super init];
    if (self) {
        self.sectionTitleIndex = titleIndex;
        self.viewHeader = viewHeader;
        self.viewFooter = viewFooter;
        self.heightHeader = heightHeader;
        self.heightFooter = heightFooter;
        self.cellObjects = cellObjects;
        self.isOpened = YES;
        
        [self checkClassAttributes];
    }
    return self;
}


#pragma mark - Private Methods

-(void) checkClassAttributes {
    if (!self.sectionTitleIndex) {
        NSLog(@"%@Section title param index is null", warningString);
        self.sectionTitleIndex = @"";
    }
    if (!self.heightHeader) {
        NSLog(@"%@Height header param is null", warningString);
        if (self.viewHeader) {
            self.heightHeader = [NSNumber numberWithDouble:self.viewHeader.frame.size.height];
        } else {
            self.heightHeader = [NSNumber numberWithInt:0];
        }
    }
    if (!self.heightFooter) {
        NSLog(@"%@Height footer param is null", warningString);
        if (self.viewFooter) {
            self.heightFooter = [NSNumber numberWithDouble:self.viewFooter.frame.size.height];
        } else {
            self.heightFooter = [NSNumber numberWithInt:0];
        }
    }
    if (!self.viewHeader) {
        NSLog(@"%@View header param is null", warningString);
        self.viewHeader = [UIView new];
    }
    if (!self.viewFooter) {
        NSLog(@"%@View footer param is null", warningString);
        self.viewFooter = [UIView new];
    }
    
    if (!self.cellObjects) {
        NSLog(@"%@cell objects param is null", warningString);
        self.cellObjects = [NSMutableArray array];
    }
}


#pragma mark - Getters

-(UIView *) getHeader {
    return self.viewHeader;
}

-(UIView *) getFooter {
    return self.viewFooter;
}

-(CGFloat) getHeaderHeight {
    return self.heightHeader.floatValue;
}

-(CGFloat) getFooterHeight {
    return self.heightFooter.floatValue;
}

-(NSInteger) getNumberOfRows {
    if (self.isOpened) {
        return [self.cellObjects count];
    } else {
        return 0;
    }
}

-(NSInteger) getTotalNumberOfRows {
    return [self.cellObjects count];
}

-(RowElement *) getRowAtPosition:(NSInteger) position {
    if (position > self.cellObjects.count || position < 0) {
        NSLog(@"%@Attempting to get a Row from a position that exceeds the limit of the elements array", warningString);
        return nil;
    }
    return self.cellObjects[position];
}

-(CGFloat) getRowHeightAtPosition:(NSInteger) position {
    if (position > self.cellObjects.count || position < 0) {
        NSLog(@"%@Attempting to get a Row from a position that exceeds the limit of the elements array", warningString);
        return -1;
    }
    return [self.cellObjects[position] getHeightCell];
}

-(NSString *) getSectionTitleIndex {
    return self.sectionTitleIndex;
}

#pragma mark - Managing the insertion of new cells

-(void) insertRowElement: (RowElement *) rowElement AtIndex: (NSInteger)index {
    [self.cellObjects insertObject:rowElement atIndex:index];
    //    sectionElement.
}

-(void) insertRowElements: (NSMutableArray *) rowElements AtIndex: (NSInteger)index {
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(index,rowElements.count)];
    [self.cellObjects insertObjects:rowElements atIndexes:indexes];
}

#pragma mark - Managing the deletion of new cells

-(void) deleteRowElementAtIndex: (NSInteger)index {
    [self.cellObjects removeObjectAtIndex:index];
}

-(void) deleteRowElements: (NSInteger) numberOfRowElements AtIndex: (NSInteger)index {
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(index,numberOfRowElements)];
    [self.cellObjects removeObjectsAtIndexes:indexes];
}

#pragma mark - Managing the replacement of new cells

-(void) replaceRowElementAtIndex: (NSInteger) index WithRowElement: (RowElement *) rowElement {
    [self.cellObjects replaceObjectAtIndex:index withObject:rowElement];
}

#pragma mark - Managing the opening and close of section

-(void) setUpHeaderRecognizer {
//    NSLog(@"setUpHeaderRecognizer");
    [self.viewHeader setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(toggleOpen:)];
    [self.viewHeader addGestureRecognizer:tapGesture];
}

- (IBAction)toggleOpen:(id)sender {
    NSLog(@"toggleOpen");
    [self toggleOpenWithUserAction:YES];
}

- (void)toggleOpenWithUserAction:(BOOL)userAction {
    if (self.delegate) {
        self.isOpened = !self.isOpened;
        
        // if this was a user action, send the delegate the appropriate message
        if (userAction) {
            if (self.isOpened) {
                if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
                    [self.delegate sectionHeaderView:self sectionOpened:0];
                }
            } else {
                if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
                    [self.delegate sectionHeaderView:self sectionClosed:0];
                }
            }
        }
    }
    // toggle the disclosure button state
    
}

@end
