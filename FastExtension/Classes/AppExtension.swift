//
//  AppExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/6/29.
//

extension FastExtensionWrapper where Base: UIApplication {
    public static var appVersion:String {
        return ""
    }
    
    public static var bundleIdentifier:String {
        return Bundle.main.bundleIdentifier ?? "null"
    }
}

