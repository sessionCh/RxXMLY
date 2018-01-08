//
//  HCHomeSearchBarable.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/15.
//  Copyright © 2017年 sessionCh. All rights reserved.
//  首页导航栏 标题搜索

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import NSObject_Rx
import Then
import SnapKit

// MARK:- 常量
fileprivate struct Metric {
    
    static let title: String = "养生 | 健身 | 艾灸 | 国家宝藏 | 72小时情感急症室"
    static let fontSize: CGFloat = 13.0
    
    static let iconWidth: CGFloat = 20.0
    static let searchBarWidth: CGFloat = kScreenW - MetricGlobal.margin * 16
    static let searchBarHeight: CGFloat = 30.0
}

protocol HCHomeSearchBarable {
    
}

extension HCHomeSearchBarable where Self : UIView {
    
    // MARK:- 自定义组件
    func searchBar(model: HCNavigationBarItemModel, onNext: @escaping (_ model: HCNavigationBarItemModel)->Void) -> UIView {
        
        // 创建组件
        let view = UIView().then {
            $0.backgroundColor = .clear
        }
        let backView = UIView().then {
            $0.backgroundColor = kThemeGainsboroColor
            $0.layer.cornerRadius = Metric.searchBarHeight / 2
            // 处理点击事件
            $0.rx.tapGesture().when(.recognized)
                .subscribe({ _ in
                    onNext(model)
                }).disposed(by: rx.disposeBag)
        }
        let icon = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "search_btn_norm")
        }
        let lab = UILabel().then {
            $0.textColor = kThemeGreyColor
            $0.font = UIFont.systemFont(ofSize: Metric.fontSize)
            $0.text = Metric.title
        }
        
        // 添加组件
        backView.addSubview(icon)
        backView.addSubview(lab)
        
        view.addSubview(backView)
        
        self.addSubview(view)
        
        // 添加约束
        view.snp.makeConstraints { (make) in
            make.width.equalTo(Metric.searchBarWidth)
            make.height.equalTo(Metric.searchBarHeight)
        }
        
        backView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        icon.snp.makeConstraints { (make) in
            make.width.equalTo(Metric.iconWidth)
            make.left.equalToSuperview().offset(MetricGlobal.margin)
            make.centerY.equalToSuperview()
        }
        
        lab.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(MetricGlobal.margin / 2)
            make.centerY.equalTo(icon)
            make.right.lessThanOrEqualToSuperview().offset(-MetricGlobal.margin)
        }
        
        return view
    }
}
