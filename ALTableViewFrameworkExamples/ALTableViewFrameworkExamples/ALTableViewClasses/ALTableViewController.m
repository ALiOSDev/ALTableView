//
//  ALTableViewController.m
//  ALTableViewFramework
//
//  Created by Abimael Barea Puyana on 6/11/15.
//
//

#import "ALTableViewController.h"
#import "ALTableViewConstants.h"
#import "SectionManager.h"

@interface ALTableViewController ()

@property(strong, nonatomic) SectionManager *sectionManager;
@property(assign, nonatomic) CGRect frame;

@end

@implementation ALTableViewController


#pragma mark - Constructor

-(void) commonInitWithSections:(NSArray<__kindof SectionElement *> *) sections {
    self.sectionManager = [SectionManager sectionManagerWithSections:sections];
    self.sectionManager.delegate = self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self commonInitWithSections:nil];
    }
    return self;
}

+ (instancetype)tableViewControllerWithFrame:(CGRect)frame style:(UITableViewStyle)style backgroundView: (UIView*) backgroundView backgroundColor: (UIColor*) backgroundColor sections:(NSArray*)sections {
    return [[self alloc] initWithFrame:frame style:style backgroundView:backgroundView backgroundColor:backgroundColor sections:sections];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style backgroundView: (UIView*) backgroundView backgroundColor: (UIColor*) backgroundColor sections:(NSArray*)sections {
    self = [super initWithStyle:style];
    if (self) {
        self.frame = frame;
        [self commonInitWithSections:sections];
        
        self.tableView.backgroundView = backgroundView;
        self.tableView.backgroundColor = backgroundColor;
    }
    return self;
}

+ (instancetype)tableViewControllerWithParams:(NSMutableDictionary *) dic {
    return [[self alloc] initWithParams:dic];
}

- (instancetype)initWithParams:(NSMutableDictionary *) dic {
    self = [super initWithStyle:[dic[PARAM_ALTABLEVIEWCONTROLLER_STYLE] integerValue]];
    if (self) {
        self.frame = CGRectFromString(dic[PARAM_ALTABLEVIEWCONTROLLER_FRAME]);
        [self commonInitWithSections:dic[PARAM_ALTABLEVIEWCONTROLLER_SECTIONS]];

        self.tableView.backgroundView = dic[PARAM_ALTABLEVIEWCONTROLLER_BACKGROUND_VIEW];
        self.tableView.backgroundColor = dic[PARAM_ALTABLEVIEWCONTROLLER_BACKGROUND_COLOR];
        
//        self.modeSectionsExpandable = [dic[PARAM_ALTABLEVIEWCONTROLLER_MODE_SECTIONS_EXPANABLE] boolValue];
        self.modeSectionsIndexTitles = [dic[PARAM_ALTABLEVIEWCONTROLLER_MODE_SECTIONS_INDEX_TITLE] boolValue];
        
        [self checkClassAttributes];
    }
    return self;
}

-(void) awakeFromNib {
    [self commonInitWithSections:nil];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = self.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private methods

-(void) checkClassAttributes {
    // TODO: Check properties
}

-(BOOL) checkParametersSection: (NSInteger) section {
    if (!(section < [self.sectionManager getNumberOfSections])) {
        NSLog(@"Attempting to access a row in a non-existing section");
        return NO;
    }
    return YES;
}

-(BOOL) checkParametersSection: (NSInteger) section Row: (NSInteger) row {
    if (!(section < [self.sectionManager getNumberOfSections])) {
        NSLog(@"Attempting to access a row in a non-existing section");
        return NO;
    }
    
    if (!(row < [self.sectionManager getNumberOfRows:section])) {
        NSLog(@"Attempting to access a row from a non-existing row");
        return NO;
    }
    return YES;
}

- (void)setModeMoveCells:(BOOL) move {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.tableView addGestureRecognizer:longPress];
}


#pragma mark - Public methods

#pragma mark class register

-(void) registerClass: (Class) classToRegister CellIdentifier: (NSString *) cellIdentifier {
    [self.tableView registerClass:classToRegister forCellReuseIdentifier:cellIdentifier];
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
}


#pragma mark Managing the replacement of new cells

-(BOOL) replaceRowElementAtIndexPath: (NSIndexPath *) indexPath WithRowElement: (RowElement *) rowElement{
    return [self replaceRowElementAtSection:indexPath.section Row:indexPath.row WithRowElement:rowElement];
}

-(BOOL) replaceRowElementAtSection: (NSInteger) section Row: (NSInteger) row WithRowElement: (RowElement *) rowElement{
    if (![self checkParametersSection:section Row:row]) {
        return NO;
    }
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    NSMutableArray *indexPathArray = [NSMutableArray arrayWithObject:indexPath];
    [self.sectionManager replaceRowElementAtSection:section Row:row WithRowElement:rowElement];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    return YES;
}


#pragma mark Managing the exchange of new cells

-(BOOL) exchangeRowElementAtIndexPath:(NSIndexPath *) indexPathFirst WithRowElementAtIndexPath:(NSIndexPath *) indexPathSecond {
    //The element that is moving is the one located ad indexPathSecond
    if (![self checkParametersSection:indexPathFirst.section Row:indexPathFirst.row]) {
        return NO;
    }
    if (![self checkParametersSection:indexPathSecond.section Row:indexPathSecond.row]) {
        return NO;
    }
    
    // Retrive rowElements
    RowElement * rowElementFirst = [self.sectionManager getRowElementAtIndexPath:indexPathFirst];
    RowElement * rowElementSecond = [self.sectionManager getRowElementAtIndexPath:indexPathSecond];
    
    // Exchange betwenn sections
    if (indexPathFirst.section != indexPathSecond.section) {
        NSInteger difference = indexPathSecond.section - indexPathFirst.section;
        if (difference < 0) {//Moving to next section, we insert the first row at the begining
            [self removeRowElementAtIndexPath:indexPathSecond];
            [self insertRowElement:rowElementSecond AtTheBeginingOfSection:indexPathFirst.section];
        } else {//Moving to previous section, we insert the first row at the end
            //TODO mirar porque no se puede insertar al final
            [self removeRowElementAtIndexPath:indexPathSecond];
//            [self insertRowElement:rowElementSecond AtTheEndOfSection:indexPathFirst.section];
            [self insertRowElement:rowElementSecond AtIndexPath:indexPathFirst];
        }
        
        //Old code
//        [self replaceRowElementAtIndexPath:indexPathSecond WithRowElement:rowElementFirst];
//        [self replaceRowElementAtIndexPath:indexPathFirst  WithRowElement:rowElementSecond];
        return YES;
    }
    
    // Exchange in current section
    [self.sectionManager replaceRowElementAtSection:indexPathFirst.section Row:indexPathSecond.row WithRowElement:rowElementFirst];
    [self.sectionManager replaceRowElementAtSection:indexPathSecond.section Row:indexPathFirst.row WithRowElement:rowElementSecond];
    
//    NSMutableArray * indexPaths = [NSMutableArray array];
//    [indexPaths addObject:indexPathFirst];
//    [indexPaths addObject:indexPathSecond];
    
    [self.tableView beginUpdates];
//    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView moveRowAtIndexPath:indexPathFirst toIndexPath:indexPathSecond];
    [self.tableView endUpdates];
    
    return YES;
}


#pragma mark Managing the insertion of new cells

-(BOOL) insertRowElement:(RowElement *) rowElement AtTheEndOfSection: (NSInteger) section {
    return [self insertRowElement:rowElement AtSection:section Row:[self.sectionManager getNumberOfRows:section]];
}

-(BOOL) insertRowElements:(NSMutableArray *) rowElements AtTheEndOfSection: (NSInteger) section {
    return [self insertRowElements:rowElements AtSection:section Row:[self.sectionManager getNumberOfRows:section]];
}

-(BOOL) insertRowElement:(RowElement *) rowElement AtTheBeginingOfSection: (NSInteger) section {
    return [self insertRowElement:rowElement AtSection:section Row:0];
}

-(BOOL) insertRowElements:(NSMutableArray *) rowElements AtTheBeginingOfSection: (NSInteger) section {
    return [self insertRowElements:rowElements AtSection:section Row:0];
}

-(BOOL) insertRowElement:(RowElement *) rowElement AtIndexPath: (NSIndexPath *) indexPath {
    return [self insertRowElement:rowElement AtSection:indexPath.section Row:indexPath.row];
}

-(BOOL) insertRowElement:(RowElement *) rowElement AtSection: (NSInteger) section Row: (NSInteger) row {
    if (![self checkParametersSection:section Row:row-1]) {
        return NO;
    }
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    NSMutableArray *indexPathArray = [NSMutableArray arrayWithObject:indexPath];
    [self.sectionManager insertRowElement:rowElement AtSection:section Row:row];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    return YES;
}

-(BOOL) insertRowElements:(NSMutableArray *) rowElements AtIndexPath: (NSIndexPath *) indexPath {
    return [self insertRowElements:rowElements AtSection:indexPath.section Row:indexPath.row];
}

-(BOOL) insertRowElements:(NSMutableArray *) rowElements AtSection: (NSInteger) section Row: (NSInteger) row {
    if (![self checkParametersSection:section Row:row-1]) {
        return NO;
    }
    NSMutableArray *indexPathArray = [NSMutableArray array];
    for (int i = 0; i < rowElements.count ; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:(row + i) inSection:section];
        [indexPathArray addObject:index];
    }
    [self.sectionManager insertRowElements:rowElements AtSection:section Row:row];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    return YES;
}


#pragma mark Managing the deletion of cells

-(BOOL) removeRowElementAtTheBeginingOfSection: (NSInteger) section {
    return [self removeRowElementAtSection:section Row:0];
}

-(BOOL) removeRowElements:(NSInteger) numberOfElements AtTheBeginingOfSection: (NSInteger) section {
    return [self removeRowElements:numberOfElements AtSection:section Row:0];
}

-(BOOL) removeRowElementAtTheEndOfSection: (NSInteger) section {
    return [self removeRowElementAtSection:section Row:([self.sectionManager getNumberOfRows:section] - 1)];
}

-(BOOL) removeRowElements:(NSInteger) numberOfElements AtTheEndOfSection: (NSInteger) section {
    return [self removeRowElements:numberOfElements AtSection:section Row:([self.sectionManager getNumberOfRows:section] - numberOfElements)];
}

-(BOOL) removeRowElementAtIndexPath: (NSIndexPath *) indexPath {
    return [self removeRowElementAtSection:indexPath.section Row:indexPath.row];
}

-(BOOL) removeRowElementAtSection: (NSInteger) section Row: (NSInteger) row {
    if (![self checkParametersSection:section Row:row]) {
        return NO;
    }
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    NSMutableArray *indexPathArray = [NSMutableArray arrayWithObject:indexPath];
    [self.sectionManager deleteRowElementAtSection:section Row:row];
    //    [self.sectionManager insertRowElement:rowElement AtSection:section Row:row];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    return YES;
}

-(BOOL) removeRowElements: (NSInteger) numberOfElements AtIndexPath: (NSIndexPath *) indexPath {
    return  [self removeRowElements:numberOfElements AtSection:indexPath.section Row:indexPath.row];
}

-(BOOL) removeRowElements: (NSInteger) numberOfElements AtSection: (NSInteger) section Row: (NSInteger) row {
    if (![self checkParametersSection:section Row:row]) {
        return NO;
    }
    if (numberOfElements > ([self.sectionManager getNumberOfRows:section] - row)) {
        NSLog(@"Attempting to delete more elements that there are on this section");
        return NO;
    }
    
    NSMutableArray *indexPathArray = [NSMutableArray array];
    for (int i = 0; i < numberOfElements ; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:(row + i) inSection:section];
        [indexPathArray addObject:index];
    }
    [self.sectionManager deleteRowElements:numberOfElements AtSection:section Row:row];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    return YES;
}


#pragma mark Manage Sections

-(BOOL) insertSectionElementAtTheBeginingOfTableView:(SectionElement *) section {
    return [self insertSectionElement:section AtSection:0];
}

-(BOOL) insertSectionElementAtTheEndOfTableView:(SectionElement *) section {
    return [self insertSectionElement:section AtSection:[self.sectionManager getNumberOfSections]];
}

-(BOOL) insertSectionElement:(SectionElement *) section AtIndexPath: (NSIndexPath *) indexPath {
    return [self insertSectionElement:section AtSection:indexPath.section];
}

-(BOOL) insertSectionElement:(SectionElement *) section AtSection:(NSInteger) position {
    if (![self checkParametersSection:position]) {
        return NO;
    }
    
    [self.sectionManager insertSection:section AtPosition:position];
    [self.tableView beginUpdates];
    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:position] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    return YES;
}

-(BOOL) replaceSectionElementAtIndexPath: (NSIndexPath *) indexPath WithSectionElement: (SectionElement *) sectionElement {
    return [self replaceSectionElementAtSection:indexPath.section WithSectionElement:sectionElement];
}




-(BOOL) replaceSectionElementAtSection: (NSInteger) section WithSectionElement: (SectionElement *) sectionElement {
    if (![self checkParametersSection:section]) {
        return NO;
    }
    [self.sectionManager replaceSection:sectionElement AtPosition:section];
    [self.tableView beginUpdates];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    return YES;
}

-(BOOL) removeSectionElementAtIndexPath: (NSIndexPath *) indexPath {
    return [self removeSectionElementAtSection:indexPath.section];
}

-(BOOL) removeSectionElementAtSection:(NSInteger) section {
    if (![self checkParametersSection:section]) {
        return NO;
    }
    [self.sectionManager removeSectionAtPosition:section];
    [self.tableView beginUpdates];
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    return YES;
}

-(void) replaceAllSectionElements:(NSMutableArray *) sections {
    [self.sectionManager replaceAllSections:sections];
    [self.tableView reloadData];
}

-(NSMutableArray *) getAllSectionElements {
    return [self.sectionManager getAllSections];
}


#pragma mark - SectionManager protocol

-(void) sectionOpenedAtIndex: (NSInteger) index NumberOfElements:(NSInteger)numberOfElements {
//    NSLog(@"section %d opened, numberOfElements: %d", index, numberOfElements);
    NSInteger countOfRowsToInsert = numberOfElements;
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:index]];
    }
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

-(void) sectionClosedAtIndex: (NSInteger) index NumberOfElements:(NSInteger)numberOfElements {
//    NSLog(@"section %d closed, numberOfElements: %d", index, numberOfElements);
    NSInteger countOfRowsToInsert = numberOfElements;
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:index]];
    }
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToInsert withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionManager getNumberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionManager getNumberOfRows:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.sectionManager getCellFromTableView:tableView IndexPath:indexPath];
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.modeSectionsIndexTitles) {
        return [self.sectionManager getSectionIndexTitles];
    } else {
        return [NSArray array];
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}


#pragma mark - UITableView Delegate

#pragma mark Configuring Rows

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.sectionManager getCellHeightFromIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ([self.sectionManager getNumberOfSections] - 1) && indexPath.row == ([self.sectionManager getNumberOfRows:indexPath.section] - 1)) {
        //We reached the end of the tableView
        if ([self.additionalDelegate respondsToSelector:@selector(tableViewDidReachEnd)]) {
            [self.additionalDelegate performSelector:@selector(tableViewDidReachEnd)];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TableViewReachedEnd" object:nil];
        }
    }
}


#pragma mark Managing Selections

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

-(void) executeAction: (UIViewController *) viewController {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(executeAction:)]) {
        [cell executeAction:self];
    }
    RowElement * rowElement = [self.sectionManager getRowElementAtIndexPath:indexPath];
    [rowElement rowElementPressed:self Cell:cell];
}

-(void) cellDeselected {
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(cellDeselected)]) {
        [cell cellDeselected];
    }
    RowElement * rowElement = [self.sectionManager getRowElementAtIndexPath:indexPath];
    [rowElement rowElementDeselected:cell];
    return indexPath;
}


#pragma mark Modifying Header and Footer of Sections

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    SectionElement * sectionElement = [self getAllSections][section];
//    NSLog(@"%d, %d",section, [sectionElement getTotalNumberOfRows]);
//    if (self.modeSectionsExpandable) {
//        [self.sectionManager setUpHandlerForSectionAtIndex:section];
//    }
    return [self.sectionManager getSectionHeaderFromSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self.sectionManager getSectionFooterFromSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.sectionManager getSectionHeaderHeightFromSection:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.sectionManager getSectionFooterHeightFromSection:section];
}


#pragma mark Tracking the Removal of Views

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ////NSLog(@"hiding cell at indexPath: %d,%d",indexPath.row,indexPath.section);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    ////NSLog(@"hiding headerView");
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    ////NSLog(@"hiding footerView");
}


#pragma mark - Move Cells

// TODO: Review and clean up

- (IBAction)longPressGestureRecognized:(id)sender {
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: { // Start
            if (!indexPath) {
                break;
            }
            sourceIndexPath = indexPath;
            
            // Take a snapshot of the selected row using helper method.
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            snapshot = [self customSnapshoFromView:cell];
            
            // Add the snapshot as subview, centered at cell's center...
            __block CGPoint center = cell.center;
            snapshot.center = center;
            snapshot.alpha = 0.0;
            [self.tableView addSubview:snapshot];
            
            [UIView animateWithDuration:0.25 animations:^{
                // Offset for gesture location.
                center.y = location.y;
                snapshot.center = center;
                snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                snapshot.alpha = 0.98;
                cell.alpha = 0.0;
            } completion:^(BOOL finished) {
                cell.hidden = YES;
            }];
            break;
        }
        case UIGestureRecognizerStateChanged: { // Movement
//            CGFloat difference = location.y - snapshot.center.y;
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            CGRect visibleFrame = snapshot.frame;
            CGFloat factor = 5;
            CGFloat frameHeight = visibleFrame.size.height * factor;
            CGFloat frameOriginY = visibleFrame.origin.y - frameHeight/2;
            if (frameOriginY < 0) {//Control that never scrolls to negative positions
                frameOriginY = 0;
                frameHeight = visibleFrame.size.height;
            }
            visibleFrame.origin.y = frameOriginY;
            visibleFrame.size.height = frameHeight;
            //Basicamente es lo mismo que lo de arriba, pero escrito de otra forma que se lee peor, aunque con menos lineas
//            CGFloat factor = 2;
//            CGFloat newOriginY = visibleFrame.origin.y - visibleFrame.size.height*factor;
//            visibleFrame.origin.y = MAX(0, newOriginY);//Control that never scrolls to negative positions
//            visibleFrame.size.height *= (factor*2 + 1);

            [self.tableView scrollRectToVisible:visibleFrame animated:NO];
            
            //TODO controlar bien el auto scroll del tableview cuando vas moviendo el snapshot
            //Con el setContentOffset se vuelve loquisimo
//            CGPoint newContentOffset = CGPointMake(0, location.y);
//            [self.tableView setContentOffset:newContentOffset animated:YES];

            //Con el scroll toRowAtIndexPath se vuelve un poco loco pero es "manejable"
            
            //Todo este codigo para que haga scroll segun va bajando o subiendo en el tableview
//            NSIndexPath * nextIndexPath;
//            if (difference > 0) {//We are moving down
//                nextIndexPath = [self.sectionManager getNextIndexPathToIndexPath:indexPath];
//            } else {//We are moving up
//                nextIndexPath = [self.sectionManager getPreviousIndexPathToIndexPath:indexPath];
//            }
//            [self.tableView scrollToRowAtIndexPath:nextIndexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
            
            //Solo con la linea de abajo para que se quedase centrado
//            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];

            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // move rows & update datasource
                [self exchangeRowElementAtIndexPath:indexPath WithRowElementAtIndexPath:sourceIndexPath];
                
                // we keep the cell hidden
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                cell.hidden = YES;
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        }
        default: { // Clean up.
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            
            [UIView animateWithDuration:0.25 animations:^{
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
            } completion:^(BOOL finished) {
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
            }];
            break;
        }
    }
}

/** @brief Returns a customized snapshot of a given view. */
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

@end
