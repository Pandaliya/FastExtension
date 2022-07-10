//
//  ExampleDebugCase.swift
//  FastExtension
//
//  Created by pan zhang on 2022/7/6.
//

import Foundation
import UIKit

public protocol ExampleCase {
    var title: String { get set}
    var callBack: (()->())? {get set}
    func caseAction() -> Bool
    init(callBack: (()->())?)
}

 
open class ExampleCaseTableController: UITableViewController {
    public var testCase: [ExampleCase] = []
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExampleCaseTableController")
        self.tableView.estimatedRowHeight = 54
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testCase.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCaseTableController", for: indexPath)
        guard self.testCase.count > indexPath.row else {
            return cell
        }
        let cs = self.testCase[indexPath.row]
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = cs.title
            content.textProperties.color = UIColor.darkGray
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = cs.title
        }
        
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard testCase.count > indexPath.row else {
            debugPrint("something error")
            return
        }
        
        let _ = testCase[indexPath.row].caseAction()
    }
}

