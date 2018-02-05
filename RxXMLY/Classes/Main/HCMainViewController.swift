//
//  HCMainViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/14.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit
import Then

// MARK:- 全局变量
var mainViewController: HCMainViewController?

class HCMainViewController: UITabBarController {
    
    // 播放按钮
    lazy var playView = HCTabbarPlayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        mainViewController = self
    
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = kThemeWhiteColor
        UITabBar.appearance().tintColor = kThemeTomatoColor
        UITabBar.appearance().backgroundImage = UIImage.init()
        UITabBar.appearance().shadowImage = UIImage.init()

        // 没有效果
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : kThemeBlackColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : kThemeTomatoColor], for: .selected)

        self.tabBar.layer.shadowColor = kThemeGreyColor.cgColor
        self.tabBar.layer.shadowOpacity = 0.8
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        self.tabBar.layer.shadowRadius = 3

        // 初始化子控制器
        self.initSubViewControllers()
        
        // 初始化播放按钮
        self.initPalyView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.bringSubview(toFront: playView)
    }
}

// MARK:- 初始化
extension HCMainViewController {
    
    // MARK:- 是否显示播放按钮
    func isHiddenPlayView(_ isHidden: Bool) {
      
        playView.isHidden = isHidden
    }
    
    // MARK:- 初始化播放按钮
    private func initPalyView() {
        
        view.addSubview(playView)
        view.bringSubview(toFront: playView)

        playView.playBtnClickedBlock = { [weak self] (isPlay) in
            guard let `self` = self else { return }
            self.jump2Paly()
        }
        
        playView.snp.makeConstraints { (make) in
            make.width.height.equalTo(HCTabbarPlayView.with())
            make.centerX.equalToSuperview()
            if is_iPhoneX {
                make.bottom.equalToSuperview().offset(-MetricGlobal.padding / 2 - iPhoneXBottomH)
            } else {
                make.bottom.equalToSuperview().offset(-MetricGlobal.padding / 2)
            }
        }
    }

    // MARK:- 初始化控制器
    private func initSubViewControllers() {
        
        let classNameArr = ["Home", "Hear", "Find", "Mine"]
        let moduleNameArr = ["首页", "我听", "发现", "我的"]
        
        var tabArr: [UIViewController] = []
        let projectName = self.getProjectName()
        
        for i in 0..<classNameArr.count {
            
            let clsName = classNameArr[i]
            let lowStr = clsName.lowercased()
            
            let clsType = NSClassFromString(projectName+"HC"+clsName+"ViewController") as! UIViewController.Type
            let vc = clsType.init()
            vc.title = moduleNameArr[i]
            
            let image = UIImage(named: "tabbar_icon_" + lowStr + "_normal")
            let selectedImage = UIImage(named: "tabbar_icon_" + lowStr + "_pressed")
            
            let item: UITabBarItem = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -8, right: 0)
            
            vc.tabBarItem = item
            let navVc = HCBaseNavigationController(rootViewController: vc)
            tabArr.append(navVc)
        }
        let placeVC = UIViewController()
        placeVC.view.backgroundColor = kThemeWhiteColor
        
        tabArr.insert(placeVC, at: 2)
        
        self.viewControllers = tabArr
    }
    
    private func getProjectName() -> String {
        guard let infoDict = Bundle.main.infoDictionary else {
            return "."
        }
        let key = kCFBundleExecutableKey as String
        guard let value = infoDict[key] as? String else {
            return "."
        }
        return value + "."
    }
}

// MARK:- 代理
extension HCMainViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    
        if viewController == tabBarController.viewControllers![2] {
            return false
        }
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}

// MARK:- 控制器跳转
extension HCMainViewController {
    
    // MARK:- 登录
    func jump2Login() {
        
        let VC = HCBaseNavigationController(rootViewController: HCLoginViewController())
        self.present(VC, animated: true, completion: nil)
    }
    
    // MARK:- 播放
    func jump2Paly() {
        
        let VC = HCBaseNavigationController(rootViewController: HCPlayViewController())
        self.present(VC, animated: true, completion: nil)
    }
}

