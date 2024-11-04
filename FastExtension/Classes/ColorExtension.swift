//
//  ColorExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/7/4.
//

import Foundation

extension UIColor:FastExtensionCompatible {}
extension FastExtensionWrapper where Base: UIColor {
    
    /// 生成随机颜色
    public static var randomColor: UIColor {
        return UIColor.init(
            red:CGFloat(arc4random_uniform(255))/CGFloat(255.0),
            green:CGFloat(arc4random_uniform(255))/CGFloat(255.0),
            blue:CGFloat(arc4random_uniform(255))/CGFloat(255.0) ,
            alpha: 1
        )
    }
}

