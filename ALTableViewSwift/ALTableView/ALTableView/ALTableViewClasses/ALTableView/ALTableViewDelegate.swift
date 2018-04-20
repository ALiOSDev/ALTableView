//
//  ALTableViewDelegate.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 16/3/18.
//  Copyright © 2018 lorenzo villarroel perez. All rights reserved.
//

import UIKit

//MARK: - UITableViewDelegate

extension ALTableView: UITableViewDelegate {
    
    //MARK: - Configuring Rows
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.getSectionElementAt(index: indexPath.section)?.getRowHeight(at: indexPath.row) ?? 0.0
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.getSectionElementAt(index: indexPath.section)?.getRowEstimatedHeight(at: indexPath.row) ?? 0.0
    }
    
    public func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        
        return 0
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //We set up the cellHeight again to avoid stuttering scroll when using automatic dimension with cells
        let cellHeight: CGFloat = cell.frame.size.height
        self.getSectionElementAt(index: indexPath.section)?.setRowElementHeight(row: indexPath.row, height: cellHeight)
        
        if self.isLastIndexPath(indexPath: indexPath, tableView: tableView) {
            //We reached the end of the tableView
            self.delegate?.tableViewDidReachEnd?()
        }
    }
    
    //MARK: - Managing selections
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        return indexPath
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell: UITableViewCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        self.getSectionElementAt(index: indexPath.section)?.rowElementPressed(row: indexPath.row, viewController: self.viewController, cell: cell)
    }
    
    public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        
        return indexPath
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        guard let cell: UITableViewCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        self.getSectionElementAt(index: indexPath.section)?.rowElementDeselected(row: indexPath.row, cell: cell)
    }
    
    //MARK: - Modifying Header and Footer of Sections
    
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {

        return self.getSectionElementAt(index: section)?.getHeaderEstimatedHeight() ?? 0.0
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        
        return self.getSectionElementAt(index: section)?.getFooterEstimatedHeight() ?? 0.0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return self.getSectionElementAt(index: section)?.getHeaderFrom(tableView: tableView)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return self.getSectionElementAt(index: section)?.getFooterFrom(tableView: tableView)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return self.getSectionElementAt(index: section)?.getHeaderHeight() ?? 0.0
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return self.getSectionElementAt(index: section)?.getFooterHeight() ?? 0.0
    }
    
}

//MARK: - Private methods

extension ALTableView {
   
    private func isLastIndexPath (indexPath: IndexPath, tableView: UITableView) -> Bool {
        
        let isLastSection: Bool = indexPath.section == tableView.numberOfSections
        let isLastRow: Bool = indexPath.row == tableView.numberOfRows(inSection: indexPath.section)
        return isLastSection && isLastRow
    }
    
}
