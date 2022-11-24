//
//  TableViewExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/7/13.
//

import Foundation

public extension FastExtensionWrapper where Base: UITableView {
    func removeSectionPadding() {
        if #available(iOS 15.0, *) {
            base.sectionHeaderTopPadding = 0
        } else {
            
        }
    }
    
    func clearBack() {
        base.backgroundColor = .clear
        base.backgroundView = nil
    }
}

public extension FastExtensionWrapper where Base: UITableViewCell {
    
}
