//
//  ErrorExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2024/3/29.
//

import Foundation

// 使用Enum定义错误类型
public enum FEErrorLog: Error {
    public struct Context : Sendable {
        public let location: String
        public let message: String
        
        public init(
            message: String,
            file: String = #file,
            line: Int = #line,
            funcName: String = #function)
        {
            let filename = file.components(separatedBy: "/").last ?? "nil"
            self.location = "\(filename) \(funcName) Line-\(line)"
            self.message = message
        }
    }
    
    case fatal(FEErrorLog.Context)
    case error(FEErrorLog.Context)
    case info(FEErrorLog.Context)
    case debug(FEErrorLog.Context)
    
    public static func mark(_ message:String = "mark", file: String = #file, line: Int = #line, funcName: String = #function) {
        let filename = file.components(separatedBy: "/").last ?? "nil"
        debugPrint("\(filename) \(funcName) Line-\(line): \(message)")
    }
}

