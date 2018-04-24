//
//  ALTableViewPullToRefresh.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 24/4/18.
//  Copyright © 2018 ALTableView. All rights reserved.
//

import UIKit

extension ALTableView {
    
    private static let refreshControlTag = 1000
    
    public func addPullToRefresh(title: NSAttributedString = NSAttributedString(string: ""), backgroundColor: UIColor = .clear, tintColor: UIColor = .black) {
        
        if let tableView = self.tableView {
            let refreshControl: UIRefreshControl = UIRefreshControl()
            refreshControl.backgroundColor = backgroundColor
            refreshControl.tintColor = tintColor
            refreshControl.addTarget(self, action: #selector(refreshTriggered(_:)), for: .valueChanged)
            refreshControl.attributedTitle = title
            
            if #available(iOS 10.0, *) {
                tableView.refreshControl = refreshControl
            } else {
                refreshControl.tag = ALTableView.refreshControlTag
                tableView.addSubview(refreshControl)
            }
        }
    }
    
    @objc private func refreshTriggered(_ sender: Any) {
        
        self.delegate?.tableViewPullToRefresh?()
        if let tableView = self.tableView {
            if #available(iOS 10.0, *) {
                tableView.refreshControl?.endRefreshing()
            } else {
                if let refreshControl = tableView.viewWithTag(ALTableView.refreshControlTag) as? UIRefreshControl {
                    refreshControl.endRefreshing()
                }
            }
        }
    }
}
