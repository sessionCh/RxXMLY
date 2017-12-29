//
//  HCMineViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/14.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

// MARK:- 常量
fileprivate struct Metric {
    
    static let searchBarLeft: CGFloat = 12.0
    static let searchBarRight: CGFloat = 12.0
}

class HCMineViewController: HCBaseViewController {
    
    var myTitleView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTitleView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        myTitleView?.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-0.5) // 修正偏差
            make.left.equalToSuperview().offset(Metric.searchBarLeft)
            make.right.equalToSuperview().offset(-Metric.searchBarRight)
        }
    }
}

// MARK:- 初始化协议
extension HCMineViewController: HCNavTitleable {
    
    // MARK:- 标题组件
    private func initTitleView() {
        
        let mineNavBar = HCMineNavBar()
        mineNavBar.itemClicked = { (model) in }
        myTitleView = self.titleView(titleView: mineNavBar)
    }
}

