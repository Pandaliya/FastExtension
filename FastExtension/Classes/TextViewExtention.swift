//
//  TextViewExtention.swift
//  FastExtension
//
//  Created by zhang pan on 2022/11/6.
//

import Foundation

public extension FastExtensionWrapper where Base: UITextView {
    
//    func addPlaceholder(text: String, font:UIFont? = nil, color:UIColor = .lightGray) {
//        var pl: UILabel? = base.fe.placeHolderLabel
//        if pl == nil {
//            let l = UILabel()
//            l.text = text
//            l.font = font ?? base.font
//            l.textColor = color
//            l.tag = 221106
//            base.addSubview(l)
//            l.sizeToFit()
//            l.frame.origin = CGPoint(x: 5, y: (base.font?.pointSize ?? 10)/2.0)
//            pl = l
//            base.addObserver(base, forKeyPath: "text", context: nil)
//        }
//    }
//    
    var placeHolderLabel: UILabel? {
        var varCount: UInt32 = 0
        let varLists = class_copyIvarList(UITextView.self, &varCount)
        for  i in 0..<numericCast(varCount) {
            if let ivar = varLists?[i] {
                guard let varName = ivar_getName(ivar) else { return nil };
                print("属性列表：\(String(utf8String: varName) ?? "nil")")
            }else{
                print("not found property");
            }
        }
        
        return base.viewWithTag(221106) as? UILabel
    }
}



