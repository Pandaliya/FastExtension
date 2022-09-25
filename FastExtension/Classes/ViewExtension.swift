//
//  ViewExtension.swift
//  CLSAppleKit
//
//  Created by pan zhang on 2022/7/8.
//

import Foundation

public extension FastExtensionWrapper where Base: UIView {
    
    func cornered(corners:UIRectCorner?, size: CGFloat) {
        guard let corners = corners else {
            base.layer.mask = nil
            return
        }
        
        guard base.bounds != .zero else {
            return
        }
        
        let filePath : UIBezierPath = UIBezierPath.init(
            roundedRect: base.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize.init(width: size, height: size)
        )
        
        let fieldLayer : CAShapeLayer = CAShapeLayer.init()
        fieldLayer.frame = base.bounds
        fieldLayer.path = filePath.cgPath
        base.layer.mask = fieldLayer
    }
    
    
}

