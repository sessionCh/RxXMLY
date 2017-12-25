//
//  HCNavTitleable.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//  设置 导航栏标题视图

import UIKit

protocol HCNavTitleable {
    
}

extension HCNavTitleable where Self : UIViewController {
    
    // MARK:- 导航栏 自定义标题 通用组件
    func titleView(titleView : UIView) -> UIView {
        
        navigationItem.titleView = titleView
        return titleView
    }
}
