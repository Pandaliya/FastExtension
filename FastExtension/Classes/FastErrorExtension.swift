//
//  FastErrorExtension.swift
//  FFSwiftStorage
//
//  Created by pan on 2025/6/13.
//

import Foundation

public enum FastError: Error, LocalizedError {
    case dataError(message: String)
    
    public var errorDescription: String? {
        switch self {
        case .dataError(let message):
            return message
        }
    }
    
    public static let defaultDataError = FastError.dataError(message: "Data Error")
}
