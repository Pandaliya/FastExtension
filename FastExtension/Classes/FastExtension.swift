//
//  FastExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/6/29.
//

import Foundation
import UIKit

public struct FastExtensionWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol FastExtensionCompatible: AnyObject { }

extension FastExtensionCompatible {
    public var fe: FastExtensionWrapper<Self> {
        get { return FastExtensionWrapper(self) }
        set { }
    }
    
    public static var fe: FastExtensionWrapper<Self>.Type {
        get { return FastExtensionWrapper<Self>.self}
        set {}
    }
}

extension UIApplication: FastExtensionCompatible { }
extension UIDevice: FastExtensionCompatible { }
extension UIColor: FastExtensionCompatible { }
extension UIImage: FastExtensionCompatible { }
extension UIView: FastExtensionCompatible { }
extension UITableViewCell: FastExtensionCompatible { }
extension UITableView: FastExtensionCompatible { }
extension UIAlertController: FastExtensionCompatible { }

extension Bundle: FastExtensionCompatible { }


