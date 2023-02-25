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
    
    static var navigationHeight:CGFloat {
        return self.statusHeight + 44
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
    
    static var textEffectsWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows.last
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    
    static var topViewController: UIViewController? {
        guard let b = Base.fe.currentWindow else {
            return nil
        }
        
        var current = b.rootViewController
        while current?.presentedViewController != nil {
            current = current?.presentedViewController
        }
        
        if let nav = current as? UINavigationController {
            current = nav.topViewController
        } else if let tab = current as? UITabBarController{
            current = tab.selectedViewController
            if let nav = current as? UINavigationController {
                current = nav.topViewController
            }
        }
        return current
    }
    
    static func showController(
        _ controller: UIViewController,
        from: UIViewController? = nil,
        push: Bool = true,
        animate: Bool = true) -> Bool
    {
        guard let fromVC = from ?? Base.fe.topViewController else {
            return false
        }
        
        if let navi = fromVC.navigationController, push {
            navi.pushViewController(controller, animated: true)
        } else {
            fromVC.present(controller, animated: true)
        }
        
        return true
    }
    
}
