//
//  ALTableView.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 7/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

@objc protocol ALTableViewProtocol: class {
    @objc optional func tableViewPullToRefresh()
    @objc optional func tableViewDidReachEnd()
    @objc optional func tableViewWillBeginDragging()
    @objc optional func tableViewWillEndDragging()
}

class ALTableView: NSObject, ALSectionManagerProtocol {

    
    
    //MARK: - Properties
    
    private let sectionManager: ALSectionManager
    public weak var delegate: ALTableViewProtocol?
    public weak var viewController: UIViewController?
    
    //MARK: - Initializers
    
    init(sectionElements: Array<ALSectionElement>, viewController: UIViewController) {
        
        self.sectionManager = ALSectionManager(sectionElements: sectionElements)
        self.viewController = viewController
        super.init()
        self.sectionManager.delegate = self
    }
    
    //MARK: - Public methods
    
    public func register(nibName: String, reuseIdentifier: String, into tableView: UITableView) {
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    //MARK: - Private methods
    
    private func isLastIndexPath (indexPath: IndexPath, tableView: UITableView) -> Bool {
        
        let isLastSection: Bool = indexPath.section == tableView.numberOfSections
        let isLastRow: Bool = indexPath.row == tableView.numberOfRows(inSection: indexPath.section)
        return isLastSection && isLastRow
    }
    
    //MARK: - ALSectionManagerProtocol
    
    func sectionOpened(at index: Int, numberOfElements: Int) {
        
    }
    
    func sectionClosed(at index: Int, numberOfElements: Int) {
        
    }
}

//MARK: - UITableViewDelegate

extension ALTableView: UITableViewDelegate {
    
    //MARK: - Configuring Rows
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if let rowElement: ALRowElement = self.sectionManager.getRowElementAtIndexPath(indexPath: indexPath) {
            if rowElement.isEstimateHeightMode() {
                return UITableViewAutomaticDimension
            } else {
                let estimatedHeight: CGFloat = self.sectionManager.getCellHeightFrom(indexPath: indexPath)
                return estimatedHeight
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let estimatedHeight: CGFloat = self.sectionManager.getCellHeightFrom(indexPath: indexPath)
        return estimatedHeight
    }
    
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //We set up the cellHeight again to avoid stuttering scroll when using automatic dimension with cells
        let cellHeight = cell.frame.size.height
        self.sectionManager.setRowElementHeight(height: cellHeight, indexPath: indexPath)
        
        if self.isLastIndexPath(indexPath: indexPath, tableView: tableView) {
            //We reached the end of the tableView
            self.delegate?.tableViewDidReachEnd?()
        }
    }
    
    //MARK: - Managing selections
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell: ALCellProtocol = tableView.cellForRow(at: indexPath) as? ALCellProtocol,
            let rowElement: ALRowElement = self.sectionManager.getRowElementAtIndexPath(indexPath: indexPath) {
            rowElement.rowElementPressed(viewController: self.viewController, cell: cell)
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell: ALCellProtocol = tableView.cellForRow(at: indexPath) as? ALCellProtocol,
            let rowElement: ALRowElement = self.sectionManager.getRowElementAtIndexPath(indexPath: indexPath) {
            rowElement.rowElementDeselected(cell: cell)
        }
    }
}

//MARK: - UITableViewDataSource

extension ALTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        let numberOfSections: Int = self.sectionManager.getNumberOfSections()
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRows: Int = self.sectionManager.getNumberOfRows(in: section)
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell: UITableViewCell = self.sectionManager.getCellFrom(tableView: tableView, indexPath: indexPath) {
            return cell
        }
        return UITableViewCell()
    }
}


















