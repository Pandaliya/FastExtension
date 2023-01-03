//
//  FileExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/11/28.
//

import Foundation

public enum FastSandboxType: Int {
    case document = 0
    case caches = 1
    case temp = 2
}

public extension FastExtensionWrapper where Base: FileManager {
    static var documentPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last ?? ""
    }
    
    static var cachesPath: String {
        NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last ?? ""
    }
    
    static var tempPath: String {
        NSTemporaryDirectory()
    }
    
    static func absolutePath(relPath:String, type: FastSandboxType = .document) -> String {
        switch type {
        case .document:
            return Base.fe.documentPath + "\(relPath)"
        case .caches:
            return Base.fe.cachesPath + "\(relPath)"
        case .temp:
            return Base.fe.tempPath + "\(relPath)"
        }
    }
    
    func filePath(
        path: String,
        isDir:Bool = true,
        createIfNotExit: Bool = true,
        fileContent:Data? = nil,
        replace: Bool = false) -> String?
    {
        if base.fileExists(atPath: path) {
            if replace {
                do {
                    try base.removeItem(atPath: path)
                    
                    if isDir {
                        /// 参数 withIntermediateDirectories
                        ///  false: 如果中间目录不存在，不创建 抛出异常
                        ///  true: 如果中间目录不存在, 则创建中间目录
                        try base.createDirectory(atPath: path, withIntermediateDirectories: true)
                    } else {
                        try base.createFile(atPath: path, contents: fileContent)
                    }
                    return path
                } catch {
                    debugPrint(" error: \(error)")
                    return nil
                }
            }
            
            return path
        }
        
        if createIfNotExit{
            do {
                if isDir {
                    try base.createDirectory(atPath: path, withIntermediateDirectories: true)
                } else {
                    try base.createFile(atPath: path, contents: fileContent)
                }
                return path
            } catch {
                debugPrint(" error: \(error)")
                return nil
            }
        }
        
        return nil
    }
    
    func saveData(
        _ data: Data,
        relAdress:String? = nil,
        abAddress:String? = nil,
        type: FastSandboxType = .document,
        replace:Bool = true) -> String?
    {
        var path = abAddress
        if path == nil, let rd = relAdress {
            path = Base.fe.absolutePath(relPath: rd, type: type)
        }
        guard let path = path else { return nil }

        return base.fe.filePath(
            path: path,
            isDir: false,
            createIfNotExit: true,
            fileContent: data,
            replace: replace
        )
    }
}
