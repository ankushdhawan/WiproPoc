//
//  TableView+Extension.swift
//  Liscio
//
//  Created by Ajay Singh Mehra on 03/11/17.
//  Copyright © 2017 Ajay Singh Mehra. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell
{
    func removeEmptyRow()
    {
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
    }
}

extension UITableView {
    func pullToRefresh(_ vc: UIViewController, callBack: @escaping () -> Void) {
        let animator = ArrowRefreshAnimator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        addPullToRefresh(64.0, animator: animator) {
            callBack()
        }
    }

    func endPull2RefreshAndInfiniteScrolling(count: Int?) {
        if let count = count, count > 15 {
            enableInfiniteScroll = true
        } else {
            enableInfiniteScroll = false
        }
        endRefreshing()
        endInfiniteScrolling()
        reloadData()
    }

    func infiniteScrolling(_ vc: UIViewController, callBack: @escaping () -> Void) {
        let animator = DefaultInfiniteAnimator(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        addInfiniteScroll(30.0, animator: animator) {
            callBack()
        }
    }

    func showEmptyScreen(_ message: String, errorIcon: UIImage = #imageLiteral(resourceName: "menuIcon")) {
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 10, y: self.bounds.height / 2 - 50, width: self.bounds.size.width - 20, height: 100))
        noDataLabel.text = message
        noDataLabel.textColor = #colorLiteral(red: 0.7302808762, green: 0.7317310572, blue: 0.7744688392, alpha: 1)
        noDataLabel.textAlignment = .center
        noDataLabel.numberOfLines = 0
        self.backgroundView?.addSubview(noDataLabel)
        self.separatorStyle = .none
    }
}

