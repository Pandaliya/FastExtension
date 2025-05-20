//
//  DataExtension.swift
//  Pods
//
//  Created by pan on 2025/5/20.
//
import CryptoKit

extension Data: FastExtensionCompatibleValue { }
extension FastExtensionWrapper where Base == Data {
    
    /// 计算数据md5
    public var md5: String {
        let digest = Insecure.MD5.hash(data: base)
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}
