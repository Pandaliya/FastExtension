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


public extension FastExtensionWrapper where Base: UIViewController {
    
}
