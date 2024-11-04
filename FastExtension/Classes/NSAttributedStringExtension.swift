//
//  NSAttributedStringExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/10/13.
//

import Foundation

extension NSAttributedString:FastExtensionCompatible {}
public extension FastExtensionWrapper where Base: NSAttributedString {
    
    /// 属性字符串size
    /// - Parameters:
    ///   - maxW: 最大宽度
    ///   - maxH: 最大宽度
    /// - Returns: size
    func contentSize(
        maxW: CGFloat = CGFloat.greatestFiniteMagnitude,
        maxH: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize
    {
        if maxH == CGFloat.greatestFiniteMagnitude, maxW == maxH {
            // maxH, maxW 不能同时为最大值
            return .zero
        }
        
        let bounds = base.boundingRect(
            with: CGSize(width: maxW, height: maxH),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        return CGSize(width: ceil(bounds.size.width), height: ceil(bounds.size.height))
    }
    
    var rangeOfAll: NSRange {
        return NSRange(location: 0, length: base.length)
    }
}

public extension FastExtensionWrapper where Base: NSMutableAttributedString {
    func add(key: NSAttributedString.Key, value:Any) {
        base.addAttribute(key, value: value, range: rangeOfAll)
    }
}
