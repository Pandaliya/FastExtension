//
//  WindowExtension.swift
//  FastAppService
//
//  Created by pan zhang on 2022/7/19.
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
    
    static var currentWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
}
