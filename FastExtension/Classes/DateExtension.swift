//
//  DateExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/7/22.
//

import Foundation

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

extension Date {
    public func stringWithFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format  // 设置日期格式
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }
    
    // 获取本地化星期名称
    public var weekdayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
}

extension Date: FastExtensionCompatibleValue { }
public extension FastExtensionWrapper where Base == Date {
    // 转换字符串为时间
    static func convertFrom(str: String, dateFormat:String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone? = TimeZone.current) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // 固定格式，避免本地化问题
        dateFormatter.timeZone = timeZone
        // 转换为 Date 类型
        if let date = dateFormatter.date(from: str) {
            debugPrint("转换成功: \(date)")
            return date
        } else {
            debugPrint("转换失败，格式不匹配 \(str)")
        }
        return nil
    }
    
    func dateString(fommaterStr: String = "yyyy-MM-dd", timeZone: TimeZone? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = fommaterStr
        formatter.timeZone = timeZone ?? .current
        return formatter.string(from: base)
    }
}

