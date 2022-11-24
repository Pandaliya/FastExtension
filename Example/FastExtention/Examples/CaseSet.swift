//
//  FEBaseExample.swift
//  FastExtention_Example
//
//  Created by pan zhang on 2022/7/8.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import FastExtension

class ExtensionSet: ExampleCaseSet {
    var setTitle: String? = nil
    
    var cases: [ExampleCase] = []
    
    var isFold: Bool = false
    
    var foldImage: UIImage? {
        return nil
    }
    
    convenience init(title:String = "", fold:Bool = false) {
        self.init()
        self.setTitle = title
        self.isFold = fold
    }
    
    static var uiSet: ExtensionSet {
        let s = ExtensionSet.init(title: "UIKit extension", fold: true)
        return s
    }
    
    static var nsSet: ExtensionSet {
        let s = ExtensionSet.init(title: "Fundation extension", fold: true)
        s.cases = [
            DateCase()
        ]
        return s
    }
    
    static var toolsSet: ExtensionSet {
        let s = ExtensionSet.init(title: "开发工具", fold: true)
        s.cases = [
            TextTools()
        ]
        return s
    }
}


