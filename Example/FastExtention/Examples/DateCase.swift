//
//  DateCase.swift
//  FastExtention_Example
//
//  Created by pan zhang on 2022/11/15.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import FastExtension

class DateCase: ExampleCase {
    var title: String = "Date/NSDate"
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
        
        f1()
        
        return true
    }
    
    func f1() {
        debugPrint("minOfToday: \(NSDate.fe.minOfToday)")
    }
}
