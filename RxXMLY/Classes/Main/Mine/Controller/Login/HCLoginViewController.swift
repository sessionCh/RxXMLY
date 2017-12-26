//
//  HCLoginViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/26.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit
import TYPagerController

// MARK:- 常量
fileprivate struct Metric {
    
    static let margin: CGFloat = 10.0
    
    static let leftTitle = "账号密码登录"
    static let rightTitle = "快捷免密登录"

    static let pagerBarFontSize = UIFont.systemFont(ofSize: 15.0)
    static let pagerBarHeight: CGFloat = 44.0
}

class HCLoginViewController: HCBaseViewController {

    private let titles: [String] = [Metric.leftTitle, Metric.rightTitle]
    private let pageVC = TYTabPagerController().then {
        $0.pagerController.scrollView?.backgroundColor = kThemeGainsboroSmokeColor
        $0.tabBar.layout.cellWidth = kScreenW * 0.5
        $0.tabBar.layout.progressWidth = Metric.leftTitle.getSize(font: Metric.pagerBarFontSize).width + Metric.margin * 2
        $0.tabBar.layout.progressColor = kThemeTomatoColor
        $0.tabBar.layout.selectedTextColor = kThemeTomatoColor
        $0.tabBar.backgroundColor = kThemeWhiteColor
        $0.tabBar.layout.cellSpacing = 0
        $0.tabBar.layout.cellEdging = 0
        $0.tabBar.layout.normalTextFont = Metric.pagerBarFontSize
        $0.tabBar.layout.selectedTextFont = Metric.pagerBarFontSize
        $0.tabBarHeight = Metric.pagerBarHeight
    }
    private var vcs: [UIViewController] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "登录"
        
        initEnableMudule()
        
        initPageController()
    }
}

// MARK:- 初始化协议
extension HCLoginViewController: HCNavBackable, HCNavUniversalable {
    
    // MARK:- 协议组件
    func initEnableMudule() {
        
        // 登录页面 返回、注册
        let models = [HCNavBarItemMetric.back,
                      HCNavBarItemMetric.loginRegister]
        self.universals(modelArr: models) { (model) in
            
            HCLog(model.description)
            
            let type = model.type
            switch type {
            case .back:
                
                self.navigationController?.dismiss(animated: true, completion: nil)
                break
            default: break
            }
        }
        
        
        // 设置 样式
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : kThemeTomatoColor], for: .normal)
    }
    
    // MARK:- 分页控制器
    private func initPageController() {
        
        addChildViewController(pageVC)
        view.addSubview(pageVC.view)
        pageVC.delegate = self
        pageVC.dataSource = self
        pageVC.view.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        pageVC.reloadData()
        
        // 设置起始页
        pageVC.pagerController.scrollToController(at: 1, animate: false)
    }
}

// MARK:- 分页控制器协议
extension HCLoginViewController: TYTabPagerControllerDelegate, TYTabPagerControllerDataSource {
    
    func numberOfControllersInTabPagerController() -> Int {
        return titles.count
    }
    
    func tabPagerController(_ tabPagerController: TYTabPagerController, controllerFor index: Int, prefetching: Bool) -> UIViewController {
        
        let vc = UIViewController()
        vc.view.backgroundColor = kThemeWhiteColor
        return vc
    }
    
    func tabPagerController(_ tabPagerController: TYTabPagerController, titleFor index: Int) -> String {
        return titles[index]
    }
}

