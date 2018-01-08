//
//  HCHearViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/14.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

class HCHearViewController: HCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initEnableMudule()
    }
}

// MARK:- 初始化协议
extension HCHearViewController: HCNavUniversalable {
    
    // MARK:- 协议组件
    private func initEnableMudule() {
        
        // 消息 搜索
        let models = [HCNavigationBarItemMetric.message,
                      HCNavigationBarItemMetric.search]
        self.universals(modelArr: models) { (model) in HCLog(model.description) }
    }
}
