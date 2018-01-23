//
//  HCPlayViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/23.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit

class HCPlayViewController: HCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initEnableMudule()
    }
}

// MARK:- 初始化协议
extension HCPlayViewController: HCNavBackable, HCNavUniversalable {
    
    // MARK:- 协议组件
    private func initEnableMudule() {
        
        // 登录页面 返回、注册
        let models = [HCNavigationBarItemMetric.downBack,
                      HCNavigationBarItemMetric.share,
                      HCNavigationBarItemMetric.more]
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
}

