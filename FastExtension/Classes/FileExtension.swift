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

enum UserError:Swift.Error{
    case noKey(message:String)         // key 无效
    case ageBeyond     // 年级超出
}

public extension FastExtensionWrapper where Base: FileManager {
    
    // MARK: - 路径
    /// 沙盒Document目录路径
    static var documentPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last ?? ""
    }
    
    /// 沙盒缓存路径
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
    
    /// 判断目录是否存在如果不存在则创建
    /// - Parameter url: 目录路径
    /// - Returns: true: 目录存在或创建成功
    func createDirectoryIfNotExit(url: URL) throws -> Bool {
        var isDir: ObjCBool = false
        if base.fileExists(atPath: url.path, isDirectory: &isDir), isDir.boolValue == true {
            return true
        }
        
        let _ = try base.createDirectory(at: url, withIntermediateDirectories: true)
        return true
    }
    
    /// 获取目录中的所有文件
    /// - Parameters:
    ///   - atDirectory: 目录地址
    ///   - sort: 是否排序
    /// - Returns: 文件路径数组
    func allFilePath(atDirectory: String, sort: Bool = true) throws -> [String] {
        var filepaths: [String] = []
        let nameArray = try base.contentsOfDirectory(atPath: atDirectory)
        for name in nameArray {
            let fullPath = "\(atDirectory)/\(name)"
            var isDir: ObjCBool = true
            if base.fileExists(atPath: fullPath, isDirectory: &isDir), isDir.boolValue == false {
                filepaths.append(fullPath)
            }
        }
        
        return filepaths
    }
    
    func filePath(
        path: String,
        isDir:Bool = true,
        createIfNotExit: Bool = true,
        fileContent:Data? = nil,
        replace: Bool = false) throws -> String
    {
        if base.fileExists(atPath: path) {
            if replace {
                try base.removeItem(atPath: path)
                
                if isDir {
                    /// 参数 withIntermediateDirectories
                    ///  false: 如果中间目录不存在，不创建 抛出异常
                    ///  true: 如果中间目录不存在, 则创建中间目录
                    try base.createDirectory(atPath: path, withIntermediateDirectories: true)
                } else {
                    base.createFile(atPath: path, contents: fileContent)
                }
                return path
            }
            
            return path
        }
        
        if createIfNotExit{
            if isDir {
                try base.createDirectory(atPath: path, withIntermediateDirectories: true)
            } else {
                base.createFile(atPath: path, contents: fileContent)
            }
            return path
        }

        return path
    }
    
    // MARK: - 保存
    func saveData(
        _ data: Data,
        relAdress:String? = nil,
        abAddress:String? = nil,
        type: FastSandboxType = .document,
        replace:Bool = true) throws -> String?
    {
        var path = abAddress
        if path == nil, let rd = relAdress {
            path = Base.fe.absolutePath(relPath: rd, type: type)
        }
        guard let path = path else { return nil }

        return try base.fe.filePath(
            path: path,
            isDir: false,
            createIfNotExit: true,
            fileContent: data,
            replace: replace
        )
    }
    
    // MARK: - 删除
    
    /// 清空目录
    /// - Parameter path: 目录地址
    /// - Returns: 是否删除成功
    func clearDrectory(path: String) throws -> Bool{
        var isDir: ObjCBool = false
        if base.fileExists(atPath: path, isDirectory: &isDir), isDir.boolValue==true {
            do {
                try base.removeItem(atPath: path)
                try base.createDirectory(atPath: path, withIntermediateDirectories: true)
            } catch {
                debugPrint(" error: \(error)")
            }
            return true
        }
        
        return false
    }
}
