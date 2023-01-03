//
//  DictionaryExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/6/30.
//

import Foundation

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
