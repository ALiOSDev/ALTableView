//
//  SectionElement.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 7/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

protocol ALSectionHeaderViewDelegate {
    func sectionOpened(sectionElement: ALSectionElement)
    func sectionClosed(section: ALSectionElement)
}

class ALSectionElement {
    
    //MARK: - Properties
    
    private let viewHeader: UIView
    private let viewFooter: UIView
    
    private let headerHeight: Double
    private let footerHeight: Double
    
    private let isOpened: Bool = true
    private let isExpandable: Bool
    
    private var headerTapGesture: UITapGestureRecognizer?
    private var rowElements: Array<ALRowElement>
    
    init(viewHeader: UIView = UIView(), viewFooter: UIView = UIView(), headerHeight: Double = 0, footerHeight: Double = 0, isExpandable: Bool = false, rowElements: Array<ALRowElement>) {
        self.viewHeader = viewHeader
        self.viewFooter = viewFooter
        self.headerHeight = headerHeight
        self.footerHeight = footerHeight
        self.isExpandable = isExpandable
        self.rowElements = rowElements
    }
    
    
    //MARK: - Getters
    
    public func getHeader() -> UIView {
        return self.viewHeader
    }
    
    public func getFooter() -> UIView {
        return self.viewFooter
    }
    
    public func getHeaderHeight() -> Double {
        return self.headerHeight
    }

    public func getFooterHeight() -> Double {
        return self.footerHeight
    }
    
    public func getNumberOfRows() -> Int {
        if self.isOpened {
            return self.rowElements.count
        } else {
            return 0
        }
    }
    
    public func getNumberOfRealRows() -> Int {
        return self.rowElements.count
    }
    
    public func getRowElementAt(position: Int) -> ALRowElement? {
        guard position > 0 && position < self.rowElements.count else {
            return nil
        }
        let rowElement: ALRowElement = self.rowElements[position]
        return rowElement
    }
    
    public func getRowHeight(at position: Int) -> Double? {
        if let rowElement = self.getRowElementAt(position: position) {
            return rowElement.getCellHeight()
        }
        return nil
    }
    
//    public func getSectionTitleIndex() -> String {
//        return self.sectionTitleIndex
//    }
    
    //MARK: - Managing the insertion of new cells

    func insert(rowElement: ALRowElement, at index: Int) -> Void {
        self.rowElements.insert(rowElement, at: index)
    }
    
    func insert(rowElements: Array<ALRowElement>, at index: Int) -> Void {
        
    }
//    -(void) insertRowElements: (NSMutableArray *) rowElements AtIndex: (NSInteger)index {
//    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(index,rowElements.count)];
//    [self.cellObjects insertObjects:rowElements atIndexes:indexes];
//    }
    
    //MARK: - Managing the deletion of new cells
    func deleteRowElement(at index: Int) -> Void {
        self.rowElements.remove(at: index)
    }
//    -(void) deleteRowElementAtIndex: (NSInteger)index {
//    [self.cellObjects removeObjectAtIndex:index];
//    }
    func deleteRowElements(numberOfRowElements: Int, at index: Int) -> Void {
        
    }
    
//    -(void) deleteRowElements: (NSInteger) numberOfRowElements AtIndex: (NSInteger)index {
//    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(index,numberOfRowElements)];
//    [self.cellObjects removeObjectsAtIndexes:indexes];
//    }
    
    //MARK: - Managing the replacement of new cells
    func replaceRowElement(at index: Int, withRowElement rowElement: ALRowElement) {
        
    }
    
//    -(void) replaceRowElementAtIndex: (NSInteger) index WithRowElement: (RowElement *) rowElement {
//    [self.cellObjects replaceObjectAtIndex:index withObject:rowElement];
//    }
    
    //MARK: - Managing the opening and close of section
    
    func setUpHeaderRecognizer () -> Void {
        
    }
    
//    -(void) setUpHeaderRecognizer {
//    //    NSLog(@"setUpHeaderRecognizer");
//    [self.viewHeader setUserInteractionEnabled:YES];
//    self.headerTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOpen:)];
//    [self.viewHeader addGestureRecognizer:self.headerTapGesture];
//    }
    
    func toggleOpen(sender: Any) {
        if self.isExpandable {
            self.toggleOpenWith(userAction: true)
        }
    }
    
//    - (IBAction)toggleOpen:(id)sender {
//    //    NSLog(@"toggleOpen");
//    if (self.isExpandable) {
//    [self toggleOpenWithUserAction:YES];
//    }
//    }
    
    func toggleOpenWith(userAction: Bool) {
        
    }
    
//    - (void)toggleOpenWithUserAction:(BOOL)userAction {
//    if (self.delegate) {
//    self.isOpened = !self.isOpened;
//
//    // if this was a user action, send the delegate the appropriate message
//    if (userAction) {
//    if (self.isOpened) {
//    if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
//    [self.delegate sectionHeaderView:self sectionOpened:0];
//    }
//    } else {
//    if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
//    [self.delegate sectionHeaderView:self sectionClosed:0];
//    }
//    }
//    }
//    }
    // toggle the disclosure button state
    
//    }
}
































