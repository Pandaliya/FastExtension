//
//  NSStringExtention.swift
//  FastExtension
//
//  Created by pan zhang on 2024/3/29.
//

import Foundation

extension NSString:FastExtensionCompatible {}
public extension FastExtensionWrapper where Base: NSString {
    
    /// 计算字符串Size
    /// - Parameters:
    ///   - font: 展示font
    ///   - maxW: 最大宽度
    ///   - maxH: 最大高度
    /// - Returns: 字符串size
    func contentSize(
        font:UIFont,
        maxW: CGFloat = CGFloat.greatestFiniteMagnitude,
        maxH: CGFloat = CGFloat.greatestFiniteMagnitude ) -> CGSize
    {
        if maxH == CGFloat.greatestFiniteMagnitude, maxW == maxH {
            // maxH, maxW 不能同时为最大值
            return .zero
        }
        
        let bounds = base.boundingRect(
            with: CGSize(width: maxW, height: maxH),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        
        /// 如果有转义字符\n \r, 可能导致计算不准确
        /// 要设置options参数为 [.usesLineFragmentOrigin, .usesFontLeading]
        
        // 浮点数向上取整
        return CGSize(width: ceil(bounds.size.width), height: ceil(bounds.size.height))
    }
    
    static func debugInfo(file: String = #file, line: Int = #line, funcName: String = #function) -> String {
        let filename = file.components(separatedBy: "/").last ?? "nil"
        return "\(filename) \(funcName) Line-\(line):"
    }
}

