//
//  HCLoginViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/26.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit
import Then
import TYPagerController

// MARK:- 常量
fileprivate struct Metric {
        
    static let leftTitle = "账号密码登录"
    static let rightTitle = "快捷免密登录"

    static let pagerBarFontSize = UIFont.systemFont(ofSize: 15.0)
    static let pagerBarHeight: CGFloat = 49.0
}

class HCLoginViewController: HCBaseViewController {
    
    private let pageVC = TYTabPagerController().then {
        $0.pagerController.scrollView?.backgroundColor = kThemeGainsboroColor

        // 设置滚动条 属性
        $0.tabBarHeight = Metric.pagerBarHeight
        $0.tabBar.backgroundColor = kThemeWhiteColor
        $0.tabBar.layout.cellWidth = kScreenW * 0.5
        $0.tabBar.layout.progressWidth = Metric.leftTitle.getSize(font: Metric.pagerBarFontSize).width + MetricGlobal.margin * 2
        $0.tabBar.layout.progressColor = kThemeTomatoColor
        $0.tabBar.layout.selectedTextColor = kThemeTomatoColor
        $0.tabBar.layout.progressHeight = 3.0
        $0.tabBar.layout.cellSpacing = 0
        $0.tabBar.layout.cellEdging = 0
        $0.tabBar.layout.normalTextFont = Metric.pagerBarFontSize
        $0.tabBar.layout.selectedTextFont = Metric.pagerBarFontSize
    }
    
    private let titles: [String] = [Metric.leftTitle, Metric.rightTitle]
    private var vcs: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "登录"
        // 显示系统导航栏底部细线
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        
        initEnableMudule()
        
        initPageController()
    }
}

// MARK:- 初始化协议
extension HCLoginViewController: HCNavBackable, HCNavUniversalable {
    
    // MARK:- 协议组件
    private func initEnableMudule() {
        
        // 登录页面 返回、注册
        let models = [HCNavigationBarItemMetric.back,
                      HCNavigationBarItemMetric.loginRegister]
        self.universals(modelArr: models) { [weak self] (model) in
            guard let `self` = self else { return }
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
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: kThemeTomatoColor], for: .normal)
    }
    
    // MARK:- 分页控制器
    private func initPageController() {
        
        // 给 PageTabBar 添加一个底部细线
        let bottomLine = UIView().then {
            $0.backgroundColor = kThemeGainsboroColor
        }
        pageVC.tabBar.addSubview(bottomLine)

        bottomLine.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(1.0)
        }

        addChildViewController(pageVC)
        view.addSubview(pageVC.view)
        pageVC.didMove(toParentViewController: self)

        pageVC.view.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kNavibarH)
            make.left.right.bottom.equalToSuperview()
        }
        pageVC.delegate = self
        pageVC.dataSource = self
        pageVC.reloadData()

        // 设置起始页
        pageVC.pagerController.scrollToController(at: 0, animate: false)
    }
 }

// MARK:- 分页控制器协议
extension HCLoginViewController: TYTabPagerControllerDelegate, TYTabPagerControllerDataSource {
    
    func numberOfControllersInTabPagerController() -> Int {
        return titles.count
    }
    
    func tabPagerController(_ tabPagerController: TYTabPagerController, controllerFor index: Int, prefetching: Bool) -> UIViewController {
        
        if index == 0 {

            return HCAccountLoginViewController()
        }
        else if index == 1 {

            return HCThridLoginViewController()
        }

        let VC = UIViewController()
        VC.view.backgroundColor = kThemeWhiteColor
        return VC
    }
    
    func tabPagerController(_ tabPagerController: TYTabPagerController, titleFor index: Int) -> String {
        return titles[index]
    }
}


