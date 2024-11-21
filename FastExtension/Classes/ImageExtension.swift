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
    
    // 修改图标的颜色
    func tintedImage(_ color: UIColor?) -> UIImage {
        guard let c = color else { return base }
        
        if #available(iOS 13.0, *) {
            return base.withTintColor(c, renderingMode: .alwaysTemplate)
        } else {
            let img = base.withRenderingMode(.alwaysTemplate)
            return img
        }
    }
    
    
    /// 旋转图片生成新的图片
    /// - Parameter degrees: 旋转度数
    /// - Returns: 旋转后图片
    func rotated(byDegrees degrees: CGFloat) -> UIImage? {
        let radians = degrees * CGFloat.pi / 180
        
        // 计算旋转后的画布大小
        var newSize = CGRect(origin: .zero, size: base.size)
            .applying(CGAffineTransform(rotationAngle: radians)).size
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        // 开始图形上下文
        UIGraphicsBeginImageContextWithOptions(newSize, false, base.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // 将图像中心平移到画布中心
        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        // 旋转上下文
        context.rotate(by: radians)
        // 绘制图像（调整起点位置）
        base.draw(in: CGRect(
            x: -base.size.width / 2,
            y: -base.size.height / 2,
            width: base.size.width,
            height: base.size.height
        ))
        // 获取新的图像
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rotatedImage
    }
    
    // MARK: - static
    // 创建一个Layer的截图
    static func snapshotOf(layer: CALayer) -> UIImage {
        let re = UIGraphicsImageRenderer(size: layer.frame.size)
        return re.image { context in
            layer.draw(in: context.cgContext)
        }
    }
    
    /// 创建一个纯色图片
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 图片大小
    /// - Returns: 图片
    static func createPureColorImage(color: UIColor, size: CGSize) -> UIImage? {
        // 使用 UIGraphicsImageRenderer 创建图片
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            // 设置填充颜色
            color.setFill()
            // 绘制矩形
            context.fill(CGRect(origin: .zero, size: size))
        }
        return image
    }
    
}


