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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.sectionElements[ALSafe: indexPath.section]?.getRowHeight(at: indexPath.row) ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.sectionElements[ALSafe: indexPath.section]?.getRowEstimatedHeight(at: indexPath.row) ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //We set up the cellHeight again to avoid stuttering scroll when using automatic dimension with cells
        let cellHeight: CGFloat = cell.frame.size.height
        self.sectionElements[ALSafe: indexPath.section]?.getRowElementAt(index: indexPath.row)?.setCellHeight(height: cellHeight)
        
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
        
        guard let cell: UITableViewCell = tableView.cellForRow(at: indexPath),
            let rowElement: ALRowElement = self.sectionElements[ALSafe: indexPath.section]?.getRowElementAt(index: indexPath.row) else {
            return
        }
        rowElement.rowElementPressed(viewController: self.viewController, cell: cell)
        
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        guard let cell: UITableViewCell = tableView.cellForRow(at: indexPath),
            let rowElement: ALRowElement = self.sectionElements[ALSafe: indexPath.section]?.getRowElementAt(index: indexPath.row) else {
            return
        }
        rowElement.rowElementDeselected(cell: cell)
    }
    
    //MARK: - Modifying Header and Footer of Sections
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {

        return self.sectionElements[ALSafe: section]?.getHeaderEstimatedHeight() ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        
        return self.sectionElements[ALSafe: section]?.getFooterEstimatedHeight() ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return self.sectionElements[ALSafe: section]?.getHeaderFrom(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return self.sectionElements[ALSafe: section]?.getFooterFrom(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return self.sectionElements[ALSafe: section]?.getHeaderHeight() ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return self.sectionElements[ALSafe: section]?.getFooterHeight() ?? 0.0
    }
    
    //MARK: - Private methods
    
    private func isLastIndexPath (indexPath: IndexPath, tableView: UITableView) -> Bool {
        
        let isLastSection: Bool = indexPath.section == tableView.numberOfSections
        let isLastRow: Bool = indexPath.row == tableView.numberOfRows(inSection: indexPath.section)
        return isLastSection && isLastRow
    }
    
}
