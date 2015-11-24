//
//  SectionManager.m
//  ALTableViewFramework
//
//  Created by lorenzo villarroel perez on 6/11/15.
//
//

#import "SectionManager.h"
#import "ALTableViewConstants.h"
#import "SectionElement.h"
#import "RowElement.h"

@interface SectionManager ()

@property (strong, nonatomic) NSMutableArray<__kindof SectionElement *> * sections;

@end

@implementation SectionManager


#pragma mark - Constructor

+ (instancetype) sectionManagerWithSections:(NSMutableArray *) sectionsElements {
    return [[self alloc] initWithSections:sectionsElements];
}

- (instancetype)initWithSections:(NSMutableArray *) sectionsElements {
    self = [super init];
    if (self) {
        self.sections = sectionsElements;
        [self.sections makeObjectsPerformSelector:@selector(setDelegate:) withObject:self];
    }
    return self;
}


#pragma mark - Number of Sections & Cells

-(NSInteger) getNumberOfSections {
    return [self.sections count];
}

-(NSInteger) getNumberOfRows:(NSInteger) section {
    if (section > self.sections.count || section < 0) {
        NSLog(@"%@Attempting to get a section from a position that exceeds the limit of the elements array", warningString);
        return 0;
    }
    return [self.sections[section] getNumberOfRows];
}


#pragma mark - Getter Cell

-(UITableViewCell *) getCellFromTableView:(UITableView *) tableView IndexPath:(NSIndexPath *) indexPath {
    return [self getCellFromTableView:tableView Section:indexPath.section Row:indexPath.row];
}

-(UITableViewCell *) getCellFromTableView:(UITableView *) tableView Section:(NSInteger) section Row: (NSInteger) row {
    if (section > self.sections.count || section < 0) {
        NSLog(@"%@Attempting to get a section from a position that exceeds the limit of the elements array", warningString);
        return nil;
    }
    
    RowElement * rowElement = [self.sections[section] getRowAtPosition:row];
    return [rowElement getCellFromTableView:tableView];
}


#pragma mark - Sections Header & Footer Views

-(UIView *) getSectionHeaderFromIndexPath:(NSIndexPath *) indexPath {
    return [self getSectionHeaderFromSection:indexPath.section];
}

-(UIView *) getSectionHeaderFromSection:(NSInteger) section {
    if (section > self.sections.count || section < 0) {
        NSLog(@"%@Attempting to get a section from a position that exceeds the limit of the elements array", warningString);
        return nil;
    }
    return [self.sections[section] getHeader];
}

-(UIView *) getSectionFooterFromIndexPath:(NSIndexPath *) indexPath {
    return [self getSectionFooterFromSection:indexPath.section];
}

-(UIView *) getSectionFooterFromSection:(NSInteger) section {
    if (section > self.sections.count || section < 0) {
        NSLog(@"%@Attempting to get a section from a position that exceeds the limit of the elements array", warningString);
        return nil;
    }
    return [self.sections[section] getFooter];
}


#pragma mark - Cell height

-(CGFloat) getCellHeightFromIndexPath:(NSIndexPath *) indexPath {
    return [self getCellHeightFromSection:indexPath.section Row:indexPath.row];
}

-(CGFloat) getCellHeightFromSection:(NSInteger) section Row: (NSInteger) row {
    if (section > self.sections.count || section < 0) {
        NSLog(@"%@Attempting to get a section from a position that exceeds the limit of the elements array", warningString);
        return 0;
    }
    return [self.sections[section] getRowHeightAtPosition:row];
}


#pragma mark - Sections Header & Footer height

-(CGFloat) getSectionHeaderHeightFromIndexPath:(NSIndexPath *) indexPath {
    return [self getSectionHeaderHeightFromSection:indexPath.section];
}

-(CGFloat) getSectionHeaderHeightFromSection:(NSInteger) section{
    if (section > self.sections.count || section < 0) {
        NSLog(@"%@Attempting to get a section from a position that exceeds the limit of the elements array", warningString);
        return 0;
    }
    return [self.sections[section] getHeaderHeight];
}

-(CGFloat) getSectionFooterHeightFromIndexPath:(NSIndexPath *) indexPath {
    return [self getSectionFooterHeightFromSection:indexPath.section];
}

-(CGFloat) getSectionFooterHeightFromSection:(NSInteger) section {
    if (section > self.sections.count || section < 0) {
        NSLog(@"%@Attempting to get a section from a position that exceeds the limit of the elements array", warningString);
        return 0;
    }
    return [self.sections[section] getFooterHeight];
}


#pragma mark - Get Row Elements

-(RowElement *) getRowElementAtIndexPath:(NSIndexPath *) indexPath {
    return [self getRowElementAtSection:indexPath.section Row:indexPath.row];
}

-(RowElement *) getRowElementAtSection: (NSInteger) section Row: (NSInteger) row {
    return [[self.sections objectAtIndex:section] getRowAtPosition:row];
}


#pragma mark - Managing the insertion of new cells

-(void) insertRowElement: (RowElement *) rowElement AtSection: (NSInteger) section Row: (NSInteger) row {
    SectionElement * sectionElement = self.sections[section];
    [sectionElement insertRowElement:rowElement AtIndex:row];
}

-(void) insertRowElements: (NSMutableArray *) rowElements AtSection: (NSInteger) section Row: (NSInteger) row {
    SectionElement * sectionElement = self.sections[section];
    [sectionElement insertRowElements:rowElements AtIndex:row];
}


#pragma mark - Managing the deletion of cells

-(void) deleteRowElementAtSection: (NSInteger) section Row: (NSInteger) row {
    SectionElement * sectionElement = self.sections[section];
    [sectionElement deleteRowElementAtIndex:row];
}

-(void) deleteRowElements: (NSInteger) numberOfRowElements AtSection: (NSInteger) section Row: (NSInteger) row {
    SectionElement * sectionElement = self.sections[section];
    [sectionElement deleteRowElements:numberOfRowElements AtIndex:row];
}


#pragma mark - Managing the replacement of cells

-(void) replaceRowElementAtSection: (NSInteger) section Row: (NSInteger) row WithRowElement: (RowElement *) rowElement {
    SectionElement * sectionElement = self.sections[section];
    [sectionElement replaceRowElementAtIndex:row WithRowElement:rowElement];
}


#pragma mark - Managing Sections

-(void) insertSection:(SectionElement *) section AtPosition:(NSInteger) position {
    section.delegate = self;
    [self.sections insertObject:section atIndex:position];
}

-(void) replaceSection:(SectionElement *) section AtPosition:(NSInteger) position {
    section.delegate = self;
    [self.sections replaceObjectAtIndex:position withObject:section];
}

-(void) removeSectionAtPosition:(NSInteger) position {
    [self.sections removeObjectAtIndex:position];
}

-(void) replaceAllSections:(NSMutableArray *) sections {
    self.sections = nil;
    self.sections = [NSMutableArray arrayWithArray:sections];
    [self.sections makeObjectsPerformSelector:@selector(setDelegate:) withObject:self];
}

-(NSMutableArray *) getAllSections {
    return self.sections;
}


#pragma mark - Managing opening and closing of sections

-(void) setUpHandlerForSectionAtIndex: (NSInteger) index {
//    NSLog(@"setUpHandlerForSectionAtIndex %d",index);
    [self.sections[index] setUpHeaderRecognizer];
}

- (void)sectionHeaderView:(SectionElement *)sectionElement sectionOpened:(NSInteger)section {
    NSInteger index = [self.sections indexOfObject:sectionElement];
    if ([self.delegate respondsToSelector:@selector(sectionOpenedAtIndex:NumberOfElements:)]) {
        [self.delegate sectionOpenedAtIndex:index NumberOfElements:[sectionElement getTotalNumberOfRows]];
    }
}

- (void)sectionHeaderView:(SectionElement *)sectionElement sectionClosed:(NSInteger)section {
    NSInteger index = [self.sections indexOfObject:sectionElement];
    if ([self.delegate respondsToSelector:@selector(sectionClosedAtIndex: NumberOfElements:)]) {
        [self.delegate sectionClosedAtIndex:index NumberOfElements:[sectionElement getTotalNumberOfRows]];
    }
}


#pragma mark - Section Index Titles

-(NSMutableArray *) getSectionIndexTitles {
    NSMutableArray * sectionIndex = [NSMutableArray array];
    for (SectionElement *sectionE in self.sections) {
        NSString *title;
        if ((title = [sectionE getSectionTitleIndex]) != nil) {
            [sectionIndex addObject:title];
        }
    }
    return sectionIndex;
}

@end
