//
//  NSObjectExtension.swift
//  FastExtension
//
//  Created by pan on 2024/12/25.
//

import Foundation

extension NSObject:FastExtensionCompatible {}
public extension FastExtensionWrapper where Base: NSObject {
    
    
    /// 打印对象的所有属性和值
    /// - Parameter maxRecursion: 父类最大递归数，默认只打印当前类
    func printPropertiesAndValues(maxRecursion: Int = 0) {
        let mirror = Mirror(reflecting: base)
        print("Properties and values of \(type(of: base)):")

        var currentMirror: Mirror? = mirror
        var recursionCount: Int = 0
        while let unwrappedMirror = currentMirror {
            for case let (label?, value) in unwrappedMirror.children {
                print("\(label): \(value)")
            }
            currentMirror = unwrappedMirror.superclassMirror
            
            recursionCount += 1
            if recursionCount > maxRecursion { // 达到最大递归值
                break
            }
        }
    }
}
