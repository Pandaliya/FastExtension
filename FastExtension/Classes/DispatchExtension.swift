//
//  DispatchExtension.swift
//  FastExtension
//
//  Created by pan on 2024/12/26.
//

import Foundation

public extension FastExtensionWrapper where Base: DispatchQueue {
    func after(_ delay: TimeInterval, execute: @escaping () -> Void) {
        base.asyncAfter(deadline: .now() + delay, execute: execute)
    }
}
