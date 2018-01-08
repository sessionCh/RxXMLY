//
//  HCMineAnchorsable.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/14.
//  Copyright © 2017年 sessionCh. All rights reserved.
//  主播控制台

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Then
import SnapKit
import RxGesture

// MARK:- 常量
fileprivate struct Metric {
    
    static let title: String = "主播工作台"
    static let fontSize: CGFloat = 15.0
}

protocol HCMineAnchorsable {
    
}

extension HCMineAnchorsable where Self : UIView {
    
    // MARK:- 自定义组件
    func mineAnchors(model: HCNavigationBarItemModel, onNext: @escaping (_ model: HCNavigationBarItemModel)->Void) -> UIView {
        
        // 创建组件
        let view = UIView().then {
            $0.backgroundColor = UIColor.clear
            // 处理点击事件
            $0.rx.tapGesture().when(.recognized)
                .subscribe({ _ in
                    onNext(model)
                }).disposed(by: rx.disposeBag)
        }
        let lab = UILabel().then {
            $0.textColor = UIColor.black
            $0.font = UIFont.systemFont(ofSize: Metric.fontSize)
            $0.text = Metric.title
        }
        let icon = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "PHGradeArrow")
        }
        
        // 添加组件
        view.addSubview(lab)
        view.addSubview(icon)
        
        self.addSubview(view)
        
        // 添加约束
        icon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(MetricGlobal.margin)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        lab.snp.makeConstraints { (make) in
            make.right.equalTo(icon.snp.left).offset(-MetricGlobal.margin / 2)
            make.centerY.equalTo(icon)
            make.left.equalToSuperview()
        }
        
        return view
    }
}

