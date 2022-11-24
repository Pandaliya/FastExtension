//
//  ExampleDebugCase.swift
//  FastExtension
//
//  Created by pan zhang on 2022/7/6.
//

import Foundation
import UIKit

/// 测试用例协议
public protocol ExampleCase {
    var title: String { get set}
    var callBack: (()->())? {get set}
    var hasNext: Bool { get }
    func caseAction() -> Bool
    
    // UI Case
    var controller: UIViewController? { get }
    func configTableView(tableView: UITableView) -> Bool
    func configView(view: UIView) -> Bool
    func controllerDidLayout()->Bool
    
    // Func Case
    var funcIndex: Int { get }
    var funcCallback: ((FEFuncCaseTableController, Int)->(Bool))? { get }
    var funcCaseTitles: [String] { get }
    var funcController: FEFuncCaseTableController { get }
}

// 可选方法实现
public extension ExampleCase {
    
    var controller: UIViewController? {
        return ExampleCaseViewController.init(ecase: self)
    }
    
    var hasNext: Bool { return true }
    
    func configTableView(tableView: UITableView) -> Bool { return false }
    func configView(view: UIView) -> Bool { return false }
    func controllerDidLayout() -> Bool { return false }
    
    func routerToContoller(from: UIViewController? = nil, push: Bool = true) {
        if let c = self.controller {
            let _ = UIWindow.fe.showController(c, from: from, push: push)
        }
    }
    
    func routerToFuncController(from: UIViewController? = nil, push: Bool = true) {
        let _ = UIWindow.fe.showController(self.funcController, from: from, push: push)
    }
    
    var funcIndex: Int { return 0 }
    var funcCaseTitles: [String] { return [] }
    var funcCallback: ((FEFuncCaseTableController, Int)->(Bool))? { return nil }
    var funcController: FEFuncCaseTableController {
        return FEFuncCaseTableController.init(
            titles: self.funcCaseTitles,
            callBack: self.funcCallback,
            title: self.title
        )
    }
}

/// 测试用例集合协议
public protocol ExampleCaseSet {
    var setTitle: String? { get set }
    var cases: [ExampleCase] { get set }
    var isFold: Bool { get set }
    var foldImage: UIImage? { get }
}

open class ExampleCaseTableController: UITableViewController {
    public var testSets: [ExampleCaseSet] = []
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let nav = self.navigationController {
            nav.setNavigationBarHidden(self.navigationBarHidden, animated: animated)
        }
    }
    
    func setupViews() {
        self.tableView.fe.removeSectionPadding()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExampleCaseTableController")
        self.tableView.estimatedRowHeight = 54
        self.tableView.sectionHeaderHeight = 44
        self.tableView.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0.01))
    }
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return self.testSets.count
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < self.testSets.count else {
            return 0
        }
        
        if self.testSets[section].isFold {
            return 0
        }
        
        return self.testSets[section].cases.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCaseTableController", for: indexPath)
        
        guard let cs = self.exampCase(indexPath: indexPath) else {
            return cell
        }
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = cs.title
            content.textProperties.color = UIColor.darkGray
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = cs.title
        }
        
        if cs.hasNext {
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard self.testSets.count > section else {
            return nil
        }
        
        var header:FECaseSetHeader? = tableView.dequeueReusableHeaderFooterView(withIdentifier: "case_set_header") as? FECaseSetHeader
        if header == nil {
            header = FECaseSetHeader.init(reuseIdentifier: "case_set_header")
            header!.foldCallBack = { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        }
        
        header!.updateSet(cs: self.testSets[section])
        return header
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cs = self.exampCase(indexPath: indexPath) else {
            debugPrint("something error")
            return
        }
        let _ = cs.caseAction()
    }
    
    func exampCase(indexPath: IndexPath) -> ExampleCase? {
        guard indexPath.section < self.testSets.count else {
            return nil
        }
        
        guard indexPath.row < self.testSets[indexPath.section].cases.count else {
            return nil
        }
        
        return self.testSets[indexPath.section].cases[indexPath.row]
    }
}

class FECaseSetHeader: UITableViewHeaderFooterView {
    
    let arrow: CGFloat = 16.0
    
    var foldCallBack: (()->())?
    var caseSet: ExampleCaseSet? = nil
    var framedSubviews: Bool = false
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        let v = UIView()
        if #available(iOS 13.0, *) {
            v.backgroundColor = UIColor.systemGroupedBackground
        } else {
            v.backgroundColor = UIColor.init(white: 0.95, alpha: 1.0)
        }
        self.backgroundView = v
        self.addSubview(titleLabel)
        self.addSubview(markImageView)
        self.addSubview(actionButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateSet(cs: ExampleCaseSet) {
        self.markImageView.image = cs.foldImage
        guard cs.setTitle != self.caseSet?.setTitle else {
            return
        }
        
        self.caseSet = cs
        self.titleLabel.text = cs.setTitle
        self.markImageView.fe.transformAngle(self.caseSet!.isFold ? 0.0 : 90)
    }
    
    @objc func actionTouched() {
        guard self.caseSet != nil else {
            return
        }
        
        self.caseSet!.isFold = !self.caseSet!.isFold
        self.markImageView.fe.transformAngle(self.caseSet!.isFold ? 0.0 : 90)
        if let fc = self.foldCallBack {
            fc()
        }
    }
    
    override func layoutSubviews() {
        let height = self.frame.size.height
        self.titleLabel.frame = CGRect(x: 20, y: 0, width: 200, height: height)
        self.markImageView.frame = CGRect(
            x: 4,
            y: (height-arrow)/2.0,
            width: arrow,
            height: arrow
        )
        self.actionButton.frame = self.bounds
        
        super.layoutSubviews()
    }
    
    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        if #available(iOS 13.0, *) {
            tl.textColor = .systemGray
        } else {
            tl.textColor = .black
        }
        return tl
    } ()
    
    lazy var markImageView: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFit
        imgv.clipsToBounds = true
        return imgv
    }()
    
    lazy var actionButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(actionTouched), for: .touchUpInside)
        return btn
    }()
}

open class FEFuncCaseTableController: UITableViewController {
    var rowTitles:[String] = []
    var rowCallback: ((FEFuncCaseTableController, Int)->(Bool))? = nil
    
    public convenience init(titles:[String], callBack: ((FEFuncCaseTableController, Int)->(Bool))? = nil, title:String="调试项目") {
        self.init(style: .plain)
        self.rowTitles = titles
        self.rowCallback = callBack
        self.title = title
        self.hidesBottomBarWhenPushed = true
    }
    
    // MARK: - Life
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Actions
    
    // MARK: - Datas
    
    // MARK: - Views
    func setupViews() {
        self.tableView.rowHeight = 49.0
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FESubCaseTableControllerCell")
    }
    
    func setupConstraints() {
        
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowTitles.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FESubCaseTableControllerCell", for: indexPath)
        if indexPath.row < self.rowTitles.count {
            cell.textLabel?.text = self.rowTitles[indexPath.row]
        }
        return cell
    }
    
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let c = self.rowCallback {
            let _ = c(self, indexPath.row)
        }
    }
    
    
    // MARK: - Lazy
}

// 用例容器视图
open class ExampleCaseViewController: UIViewController {
    var ecase: ExampleCase!
    
    public convenience init(ecase: ExampleCase) {
        self.init()
        self.hidesBottomBarWhenPushed = true
        self.ecase = ecase
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = UIColor.systemBackground
        } else {
            self.view.backgroundColor = UIColor.white
        }
        self.navigationItem.title = self.ecase.title
        let _ = self.ecase.configView(view: self.view)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let nav = self.navigationController {
            nav.setNavigationBarHidden(self.navigationBarHidden, animated: animated)
        }
    }
}


