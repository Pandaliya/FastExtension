//
//  FastErrorExtension.swift
//  FFSwiftStorage
//
//  Created by pan on 2025/6/13.
//

import Foundation

enum FastError: Error, LocalizedError {
    case dataError(message: String)
    
    var errorDescription: String? {
        switch self {
        case .dataError(let message):
            return message
        }
    }
    
    static let defaultDataError = FastError.dataError(message: "Data Error")
}
