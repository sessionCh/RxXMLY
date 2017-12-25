//
//  HCMainViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/14.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit
import Then

class HCMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化子控制器
        self.initSubViewControllers()
        
        // 设置tabBarItem选中与未选中的文字颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : kThemeWhiteColor], for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : kThemeTomatoColor], for: UIControlState.selected)
        
        self.tabBar.tintColor = kThemeTomatoColor
        self.tabBar.backgroundColor = UIColor.white
    }
}

// MARK:- 初始化模块
extension HCMainViewController {
    
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

            let item: UITabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabbar_icon_"+lowStr+"_normal"), selectedImage: UIImage(named: "tabbar_icon_"+lowStr+"_pressed"))
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -8, right: 0)
            vc.tabBarItem = item
            vc.view.backgroundColor = UIColor.white
            let navVc = HCBaseNavigationController(rootViewController: vc)
            tabArr.append(navVc)
        }
        self.viewControllers = tabArr
    }
    
    func getProjectName() -> String {
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

