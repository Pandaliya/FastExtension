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
        if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return fileURL.path
        }
        return ""
    }
    
    /// 沙盒缓存路径
    static var cachesPath: String {
        if let fileURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            return fileURL.path
        }
        return  ""
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
    
    
    /// 在一个路径中提取文件名或目录名
    /// - Parameter path: 文件路径
    /// - Returns: 文件名
    static func nameOf(path:String) -> String{
        return path.components(separatedBy: "/").last ?? path
    }
    
    /// 在文件路径中提取目录路径
    /// - Parameter filePath: 文件路径
    /// - Returns: 目录路径
    static func directoryOf(filePath: String) -> String {
        let fileURL = URL(fileURLWithPath: filePath)
        return fileURL.deletingLastPathComponent().path
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
    
    
    // 获取文件大小（以 MB 为单位）
    func fileSizeInMB(atPath path: String) -> Double {
        let fileManager = FileManager.default
        do {
            let attributes = try fileManager.attributesOfItem(atPath: path)
            if let fileSize = attributes[.size] as? UInt64 {
                return Double(fileSize) / (1024 * 1024)  // 将字节转换为 MB
            }
        } catch {
            print("无法获取文件大小：\(error)")
        }
        return 0
    }
    
    // 递归打印目录结构，并计算目录大小
    func printDirectoryTreeAndCalculateSize(at path: String, prefix: String = "") -> Double {
        let fileManager = FileManager.default
        var totalSize: Double = 0  // 记录当前目录的总大小

        do {
            // 获取指定路径的文件和子目录
            let items = try fileManager.contentsOfDirectory(atPath: path)
            
            for (index, item) in items.enumerated() {
                let isLast = index == items.count - 1
                let itemPath = (path as NSString).appendingPathComponent(item)
                
                // 检查是否为目录或文件
                var isDirectory: ObjCBool = false
                if fileManager.fileExists(atPath: itemPath, isDirectory: &isDirectory) {
                    if isDirectory.boolValue {
                        // 如果是目录，递归打印并计算其大小
                        print("\(prefix)\(isLast ? "└── " : "├── ")\(item)/")
                        totalSize += printDirectoryTreeAndCalculateSize(at: itemPath, prefix: prefix + (isLast ? "    " : "│   "))
                    } else {
                        // 如果是文件，获取其大小并累加到总大小
                        let fileSize = fileSizeInMB(atPath: itemPath)
                        totalSize += fileSize
                        print("\(prefix)\(isLast ? "└── " : "├── ")\(item) - \(String(format: "%.2f", fileSize)) MB")
                    }
                }
            }
        } catch {
            print("无法访问目录：\(error)")
        }
        
        return totalSize
    }
    
    
    /// 移动文件，并确保中间目录存在
    /// - Parameters:
    ///   - sourcePath: 源文件地址
    ///   - destinationPath: 目标地址
    func moveFile(from sourcePath: String, to destinationPath: String) throws {
        let fileManager = FileManager.default
        let destinationURL = URL(fileURLWithPath: destinationPath)
        let destinationDirectory = destinationURL.deletingLastPathComponent()
        
        if !fileManager.fileExists(atPath: destinationDirectory.path) {
            try fileManager.createDirectory(at: destinationDirectory, withIntermediateDirectories: true, attributes: nil)
            debugPrint("已创建目录：\(destinationDirectory.path)")
        }

        // 移动文件
        try fileManager.moveItem(atPath: sourcePath, toPath: destinationPath)
        debugPrint("文件已移动到：\(destinationPath)")
    }

}
