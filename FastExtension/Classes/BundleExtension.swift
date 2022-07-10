//
//  BundleExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/7/6.
//

import Foundation

public extension FastExtensionWrapper where Base: Bundle {
    
    static func bundle(framework: String) -> Bundle? {
        var path = Bundle.main.url(forResource: "Frameworks", withExtension: nil)
        path = path?.appendingPathComponent(framework)
        path = path?.appendingPathExtension("framework")
        if let p = path {
            let bundle = Bundle.init(url: p)
            let smpath = bundle?.url(forResource: framework, withExtension: "bundle")
            if let sp = smpath {
                return Bundle.init(url: sp)
            }
        }
        return nil
    }
}
