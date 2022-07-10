//
//  ViewExtension.swift
//  CLSAppleKit
//
//  Created by pan zhang on 2022/7/8.
//

import Foundation
import UIKit


public extension FastExtensionWrapper where Base: UIWindow {
    static var statusHeight:CGFloat {
        if #available(iOS 13.0, *) {
            if let manager = UIApplication.shared.windows.first?.windowScene?.statusBarManager {
                return manager.statusBarFrame.size.height
            }
        } else {
            return UIApplication.shared.statusBarFrame.size.height
        }
        return 20
    }
}

