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
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            debugPrint(String(data: data, encoding: .utf8) ?? "nil")
        } else {
            debugPrint("something error")
        }
        #endif
    }
}
