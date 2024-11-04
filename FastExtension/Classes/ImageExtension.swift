//
//  ImageExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/7/4.
//

import Foundation

extension UIImage:FastExtensionCompatible {}
public extension FastExtensionWrapper where Base: UIImage {
    
    /// 中间两个像素拉伸的image
    var stretchEnableImage: UIImage {
        return self.stretchImage()
    }
    
    /// 中间2x2区域像素平铺
    var tileImage: UIImage {
        return self.stretchImage(mode: .tile)
    }
    
    /// 创建一个可拉伸的图像
    /// - Parameter stretchRect: 拉伸区域，若为不设置则默认拉伸图片中心2x2区域
    /// - Parameter mode: 拉伸类型
    /// - Returns: 可拉伸图像
    func stretchImage(stretchRect:CGRect? = nil, mode: UIImage.ResizingMode = .stretch) -> UIImage {
        var edge: UIEdgeInsets = .zero
        let size = base.size
        
        var srx = stretchRect
        if srx == nil {
            srx = CGRect(x: size.width/2.0 - 1, y: size.height/2-1, width: 2, height: 2)
        }
        
        if let sr = srx {
            edge = UIEdgeInsets(
                top: size.height - sr.origin.y,
                left: size.width - sr.origin.x,
                bottom: size.height - sr.origin.y - sr.size.height,
                right: size.width - sr.origin.x - sr.size.width
            )
        }
        return base.resizableImage(withCapInsets: edge, resizingMode: mode)
    }
    
    
    /// 返回Bundle中的图像
    /// - Parameters:
    ///   - name: 图像名称
    ///   - bunlde: 所属Bundle
    /// - Returns: 图像
    static func image(name:String, bunlde:Bundle?) -> UIImage? {
        guard let smb = bunlde else {
            return nil
        }
        
        if #available(iOS 13.0, *) {
            return UIImage(named: name, in: smb, with: nil)
        } else {
            return UIImage.init(named: name, in: smb, compatibleWith: nil)
        }
    }
    
    func tintedImage(_ color: UIColor?) -> UIImage {
        guard let c = color else { return base }
        
        if #available(iOS 13.0, *) {
            return base.withTintColor(c, renderingMode: .alwaysTemplate)
        } else {
            let img = base.withRenderingMode(.alwaysTemplate)
            return img
        }
    }
    
    static func snapshotOf(layer: CALayer) -> UIImage {
        let re = UIGraphicsImageRenderer(size: layer.frame.size)
        return re.image { context in
            layer.draw(in: context.cgContext)
        }
    }
    
}


