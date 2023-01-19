//
//  ViewExtension.swift
//  CLSAppleKit
//
//  Created by pan zhang on 2022/7/8.
//

import Foundation

public extension UIView {
    func debugPrintHierarchy(level:String = "") {
        
        debugPrint("\(level)\(type(of: self)) frame: \(self.frame)")
        guard self.subviews.isEmpty == false else {
            return
        }
        let nextLevel = "\(level)-"
        for v in self.subviews {
            v.debugPrintHierarchy(level: nextLevel)
        }
        return
    }
}


public extension FastExtensionWrapper where Base: UIView {
    
    var safeAreaTop: CGFloat {
        if #available(iOS 11.0, *) {
            return base.safeAreaInsets.top
        } else {
            return 0
        }
    }
    
    var safeAreaBottom: CGFloat {
        if #available(iOS 11.0, *) {
            return base.safeAreaInsets.bottom
        } else {
            return 0
        }
    }
    
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
    
    
    func fixedSnapshotImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.frame.size, false, UIScreen.main.scale);
        if let context = UIGraphicsGetCurrentContext(){
            base.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        
        return nil
    }
    
    
    // MARK: Frame
    func updateHeight(_ height: CGFloat) {
        var frame = base.frame
        frame.size.height = height
        base.frame = frame
    }
    
    func transformAngle(_ angle: CGFloat) {
        let ag = angle/180.0 * .pi
        base.transform = CGAffineTransformMakeRotation(ag)
    }
    
}

