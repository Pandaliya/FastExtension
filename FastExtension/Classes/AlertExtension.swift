//
//  AlertExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/7/26.
//

import Foundation

public extension FastExtensionWrapper where Base: UIAlertController {
    static func showAlert(
        title:String?,
        message:String?,
        cancelTitle:String = "Cancel",
        confirmTitle: String = "Confirm",
        callback:((Bool)->())? = nil)
    {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction.init(title: confirmTitle, style: .default, handler: { _ in
            if let cc = callback {
                cc(true)
            }
        }))
        alert.addAction(UIAlertAction.init(title: cancelTitle, style: .destructive, handler: { _ in
            if let cc = callback {
                cc(false)
            }
        }))
        UIWindow.fe.currentWindow?.rootViewController?.present(alert, animated: true)
    }
    
    static func showMessageAlert(title: String?, message:String?, confirmTitle:String = "Confirm") {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction.init(title: confirmTitle, style: .default))
        UIWindow.fe.currentWindow?.rootViewController?.present(alert, animated: true)
    }
    
}
