//
//  HCBaseNavigationController.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/14.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

class HCBaseNavigationController: UINavigationController, HCNavBackable {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航栏样式
        navigationBar.setBackgroundImage(UIImage.color(kThemeWhiteColor), for: UIBarPosition.any, barMetrics: .default)
        navigationBar.shadowImage = UIImage()
        
        // 标题样式
        let bar = UINavigationBar.appearance()
        bar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.black,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)
        ]
        
        // 设置返回按钮的样式
        navigationBar.tintColor = kThemeBlackColor     // 设置返回标识器的颜色
        let barItem = UIBarButtonItem.appearance()
        barItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : kThemeBlackColor], for: .normal)  // 返回按钮文字样式
    }
}
