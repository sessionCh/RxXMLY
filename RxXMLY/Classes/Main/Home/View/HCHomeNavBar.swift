//
//  HCHomeNavBar.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

// MARK:- 常量
fileprivate struct Metric {
    
    static let margin: CGFloat = 10.0
    
    static let homeBarWidth: CGFloat = kScreenW
    static let homeBarHeight: CGFloat = 44.0
}

class HCHomeNavBar: UIView {
    
    typealias AddBlock = (_ model: HCNavBarItemModel)->Void;
    var itemClicked: AddBlock? = { (_) in
        return
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initHomeNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 此处必须指定一个大小
        self.snp.makeConstraints { (make) in
            make.width.equalTo(Metric.homeBarWidth)
            make.height.equalTo(Metric.homeBarHeight)
        }
    }
}

extension HCHomeNavBar: HCHomeSearchBarable, HCNavUniversalable {
    
    // MARK:- 初始化 首页 导航栏组件
    func initHomeNavBar() {
        
        // 消息按钮
        let message = self.universal(model: HCNavBarItemMetric.message) { (model) in
            
            HCLog(model.description)
        }
        
        // 历史记录
        let history = self.universal(model: HCNavBarItemMetric.history) { (model) in
            
            HCLog(model.description)
        }
        
        // 下载
        let download = self.universal(model: HCNavBarItemMetric.download) { (model) in
            
            self.itemClicked!(model)
            HCLog(model.description)
        }
        
        // 搜索栏
        let searchBar = self.searchBar(model: HCNavBarItemMetric.homeSearchBar) { (model) in
            
            self.itemClicked!(model)
            HCLog(model.description)
        }
        
        // 布局
        message.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(message.snp.right).offset(Metric.margin)
        }
        
        history.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(searchBar.snp.right).offset(Metric.margin)
        }
        
        download.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(history.snp.right).offset(Metric.margin)
            make.right.equalToSuperview()
        }
    }
}


