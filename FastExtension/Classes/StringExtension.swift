//
//  StringExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/10/13.
//

import Foundation

public extension FastExtensionWrapper where Base: NSString {
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
}

public extension FastExtensionWrapper where Base: NSAttributedString {
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
}
