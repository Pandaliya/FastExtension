//
//  ControllerExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/11/16.
//

import Foundation

public protocol FEControllerProtocol {
    var navigationBarHidden: Bool { get }
}

public extension FEControllerProtocol {
    var navigationBarHidden: Bool { return false }
}

extension UIViewController: FEControllerProtocol {}


extension UIViewController:FastExtensionCompatible {}

public extension FastExtensionWrapper where Base: UIViewController {
    var isVisible: Bool { // 是否可见
        if base.isViewLoaded && base.view.window != nil {
            return true
        }
        return false
    }
}
