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


public protocol FastExtensionCompatibleValue {
}

extension FastExtensionCompatibleValue {
    public var fe: FastExtensionWrapper<Self> {
        get { return FastExtensionWrapper(self) }
        set { }
    }
    
    public static var fe: FastExtensionWrapper<Self>.Type {
        get { return FastExtensionWrapper<Self>.self }
        set { }
    }
}

// MARK: - FAST Cloures
public typealias FastResult = (_ result: Bool, _ errMsg: String?) -> Void
public typealias FastFinished = (_ response: Any?, _ errMsg: String?) -> Void
public typealias FastCodeFinished = (_ response: Decodable?, _ errMsg: String?) -> Void


