//
//  ALTableViewPullToRefresh.swift
//  ALTableView
//
//  Created by lorenzo villarroel perez on 24/4/18.
//  Copyright © 2018 ALTableView. All rights reserved.
//

import UIKit

extension ALTableView {
    
    public func addPullToRefresh(title: String = "", titleColor: UIColor = .black, backgroundColor: UIColor = .clear, tintColor: UIColor = .black) {
        
        if let tableView = self.tableView {
            let refreshControl = UIRefreshControl()
            refreshControl.backgroundColor = backgroundColor
            refreshControl.tintColor = tintColor
            refreshControl.addTarget(self, action: #selector(refreshTriggered(_:)), for: .valueChanged)
            
            if #available(iOS 10.0, *) {
                tableView.refreshControl = refreshControl
            } else {
                tableView.addSubview(refreshControl)
            }
        }
    }
    
    @objc private func refreshTriggered(_ sender: Any) {
        self.delegate?.tableViewPullToRefresh?()
    }
}
