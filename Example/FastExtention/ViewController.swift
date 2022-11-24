//
//  ViewController.swift
//  FastExtention
//
//  Created by zhangpan on 06/29/2022.
//  Copyright (c) 2022 zhangpan. All rights reserved.
//

import UIKit
import FastExtension

class ViewController: ExampleCaseTableController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Fase Extension"
        
        self.testSets = [
            ExtensionSet.toolsSet,
            ExtensionSet.uiSet,
            ExtensionSet.nsSet
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

