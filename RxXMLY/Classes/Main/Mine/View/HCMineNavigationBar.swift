//
//  HCMineNavigationBar.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

// MARK:- 常量
fileprivate struct Metric {
        
    static let homeBarWidth: CGFloat = kScreenW
    static let homeBarHeight: CGFloat = 44.0
}

class HCMineNavigationBar: UIView {
    
    private var mineAnchorsBackgroundView: UIView?
    
    typealias AddBlock = (_ model: HCNavigationBarItemModel)->Void;
    var itemClicked: AddBlock? = { (_) in
        return
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initMineNavigationBar()
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
        
        // 剪切圆角 (放在 HCMineAnchorsable 剪切失效，视图未创建 )
        let corners: UIRectCorner = [.bottomLeft,.topLeft]
        mineAnchorsBackgroundView?.clipCorner(direction: corners, radius: 14)
        mineAnchorsBackgroundView?.alpha = 0.35
    }
}

extension HCMineNavigationBar: HCMineAnchorsable, HCNavUniversalable {
    
    // MARK:- 初始化 我的 导航栏组件
    func initMineNavigationBar() {
        
        // 消息按钮
        let message = self.universal(model: HCNavigationBarItemMetric.meMessage) { [weak self]  (model) in
            
            guard let `self` = self else { return }
            self.itemClicked!(model)
            HCLog(model.description)
        }
        
        // 设置
        let setting = self.universal(model: HCNavigationBarItemMetric.setting) { [weak self]  (model) in
            
            guard let `self` = self else { return }
            self.itemClicked!(model)
            HCLog(model.description)
        }
        
        // 主播工作台
        let (mineAnchors, backgroundView) = self.mineAnchors(model: HCNavigationBarItemMetric.mineAnchors) { [weak self] (model) in
            
            guard let `self` = self else { return }
            self.itemClicked!(model)
            HCLog(model.description)
        }
        self.mineAnchorsBackgroundView = backgroundView
        
        // 布局
        message.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        setting.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(message.snp.right).offset(MetricGlobal.margin)
        }
        
        mineAnchors.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}

