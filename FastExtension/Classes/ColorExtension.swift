//
//  ColorExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/7/4.
//

import Foundation


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
    
    
    public static func hex(_ hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

