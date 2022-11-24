//
//  TextTools.swift
//  FastExtention_Example
//
//  Created by pan zhang on 2022/11/21.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import FastExtension

class TextTools: ExampleCase {
    var title: String = "文本开发工具"
    var callBack: (() -> ())? = nil
    
    convenience init(callBack: (() -> ())?) {
        self.init()
        self.callBack = callBack
    }
    
    func caseAction() -> Bool {
        if let callBack = callBack {
            debugPrint("\(type(of: self)) Executing: call back")
            callBack()
        }
        debugPrint("\(type(of: self))  Executing: case action")
        
        allFontFamily()
        self.routerToFuncController()
        
        return true
    }
    
    /// 所有字体
    func allFontFamily() {
        for family in UIFont.familyNames {
            print("family:", family)
            for font in UIFont.fontNames(forFamilyName: family) {
                print("font:", font)
            }
        }
    }
    
    var funcCaseTitles: [String] {
        return [
            "所有字体",
        ]
    }
    
    var funcCallback: ((FEFuncCaseTableController, Int) -> (Bool))? {
        return {[weak self] controller, index in
            guard let self = self else { return false }
            switch index {
            case 0:
                self.allFontFamily()
                break
            default:
                break
            }
            return true
        }
    }
}

