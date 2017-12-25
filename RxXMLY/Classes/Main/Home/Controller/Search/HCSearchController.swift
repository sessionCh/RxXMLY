//
//  HCSearchController.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/15.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

// MARK:- 常量
fileprivate struct Metric {
    
    static let searchBarLeft: CGFloat = 12.0
    static let searchBarRight: CGFloat = 12.0
}

class HCSearchController: HCBaseViewController {
    
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
extension HCSearchController: HCNavTitleable {
    
    // MARK:- 标题组件
    func initTitleView() {
        
        let searchBar = HCSearchNavBar()
        searchBar.itemClicked = { [] (model) in
            if case let HCNavBarItemModel.HCNavBarItemType.searchBar(index, desc) = model.type {
                HCLog(model.description + " 控件: \(desc)")
                if index == 3 {
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
        myTitleView = self.titleView(titleView: searchBar)
    }
}
