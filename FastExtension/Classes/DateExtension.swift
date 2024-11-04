//
//  DateExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/7/22.
//

import Foundation

extension NSDate:FastExtensionCompatible {}
public extension FastExtensionWrapper where Base: NSDate {
    
    /// 返回是当天的第几分钟
    static var minOfToday: Int {
        let today = Base()
        let cal = Calendar.current
        let comps = cal.dateComponents([.hour, .minute], from: today as Date)
        guard let hh = comps.hour, let mm = comps.minute else {
            return 0
        }
        debugPrint("\(hh) : \(mm)")
        return hh * 60 + mm
    }
}

