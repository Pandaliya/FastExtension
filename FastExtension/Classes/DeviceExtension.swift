//
//  DeviceExtension.swift
//  FastExtention
//
//  Created by pan zhang on 2022/6/29.
//

import Foundation

extension UIDevice:FastExtensionCompatible {}
public extension FastExtensionWrapper where Base: UIDevice {
    static func systemInfo(name: String) -> String{
        var size:Int = 0
        sysctlbyname(name, nil, &size, nil, 0)
        var machine = [CChar](repeating: 0,  count: size)
        sysctlbyname(name, &machine, &size, nil, 0)
        return String(cString: machine)
    }
    
    /// 是否为手机
    static var isPhone: Bool {
        return Base.current.userInterfaceIdiom == .phone
    }
    
    /// 设备型号，如 "iPhone8,1" (iPhone 6s)
    static var platform:String {
        return systemInfo(name: "hw.machine")
    }
    
    static var model:String {
        return systemInfo(name: "hw.model")
    }
}
