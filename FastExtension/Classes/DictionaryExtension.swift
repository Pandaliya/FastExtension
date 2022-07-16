//
//  DictionaryExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/6/30.
//

import Foundation

//public extension FastExtensionWrapper where Base:  {
//    
//}


public extension Dictionary {
    func prettyDebugPrint() {
        #if DEBUG
        if let data = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) {
            if let ds = String(data: data, encoding: .utf8) {
                print(ds)
                // debugPrint(ds) // debugPrint 不能处理字符串中的换行符（转义字符）
            }
        } else {
            debugPrint("something error")
        }
        #endif
    }
}


/* Swift 扩展添加关联对象
struct AssociatedKeys {
    static var testNameKey: String = "testNameKey"
}

extension UIView {
    public var testName: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.testNameKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.testNameKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
 */
