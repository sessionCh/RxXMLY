//
//  HCSearchControllerable.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/15.
//  Copyright © 2017年 sessionCh. All rights reserved.
//  搜索页面 标题搜索

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import NSObject_Rx
import Then
import SnapKit

// MARK:- 常量
fileprivate struct Metric {
    
    static let title: String = "搜索专辑、主播、广播、声音、大吉大利，晚上吃鸡"
    static let labFontSize: CGFloat = 13.0
    static let btnFontSize: CGFloat = 15.0
    
    static let searchBarWidth: CGFloat = kScreenW - MetricGlobal.margin * 2
    static let searchBarHeight: CGFloat = 30.0

    static let searchIconWidth: CGFloat = 30.0
    static let recordIconWidth: CGFloat = 20.0
    static let cancelBtnWidth: CGFloat = 40.0
}

protocol HCSearchControllerable {
    
}

extension HCSearchControllerable where Self : UIView {
    
    // MARK:- 自定义组件
    func searchBar(model: HCNavigationBarItemModel, onNext: @escaping (_ model: HCNavigationBarItemModel)->Void) -> UIView {
        
        // 创建组件
        let view = UIView().then {
            $0.backgroundColor = .clear
        }
        let backView = UIView().then {
            $0.backgroundColor = kThemeGainsboroColor
            $0.layer.cornerRadius = Metric.searchBarHeight / 2
        }
        let icon = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "search_btn_norm")
        }
        let searchField = UITextField().then {
            $0.clearButtonMode = .whileEditing
            $0.becomeFirstResponder()           // 成为焦点
            $0.tintColor = kThemeTomatoColor    // 光标颜色
            $0.font = UIFont.systemFont(ofSize: Metric.labFontSize)
            $0.placeholder = Metric.title
            // 处理点击事件
            $0.rx.tapGesture().when(.recognized)
                .subscribe({ _ in
                    var tModel = model
                    tModel.type = .searchBar(index: 1, desc: "输入框")
                    onNext(tModel)
                }).disposed(by: rx.disposeBag)
        }
        let record = UIImageView().then {
            // 设置属性
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "MCRecord")

            // 处理点击事件
            $0.rx.tapGesture().when(.recognized)
                .subscribe({ _ in
                    var tModel = model
                    tModel.type = .searchBar(index: 2, desc: "录音按钮")
                    onNext(tModel)
                }).disposed(by: rx.disposeBag)
        }
        
        let cancel = UIButton().then {
            // 设置属性
            $0.setTitle("取消", for: .normal)
            $0.setTitleColor(kThemeDimGrayColor, for: .normal)
            $0.setTitleColor(kThemeGreyColor, for: .highlighted)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: Metric.btnFontSize)
            // 处理点击事件
            $0.rx.tap.do(onNext: {
                var tModel = model
                tModel.type = .searchBar(index: 3, desc: "取消按钮")
                onNext(tModel)
            }).subscribe().disposed(by: rx.disposeBag)
        }

        // 添加组件
        backView.addSubview(icon)
        backView.addSubview(searchField)
        backView.addSubview(record)

        view.addSubview(backView)
        view.addSubview(cancel)
        
        self.addSubview(view)
        
        // 添加约束
        // 此处必须指定一个大小
        view.snp.makeConstraints { (make) in
            make.width.equalTo(Metric.searchBarWidth)
            make.height.equalTo(Metric.searchBarHeight)
        }
        
        backView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(cancel.snp.left).offset(-MetricGlobal.margin / 2)
        }

        cancel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(Metric.cancelBtnWidth)
            make.right.equalToSuperview()
        }
        
        icon.snp.makeConstraints { (make) in
            make.width.equalTo(Metric.searchIconWidth)
            make.left.equalToSuperview().offset(MetricGlobal.margin / 2)
            make.centerY.equalToSuperview()
        }
        
        searchField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(MetricGlobal.margin / 4)
            make.left.equalTo(icon.snp.right)
            make.centerY.equalTo(icon)
            make.right.lessThanOrEqualTo(record.snp.left)
        }
        
        record.snp.makeConstraints { (make) in
            make.centerY.equalTo(icon)
            make.width.equalTo(Metric.recordIconWidth)
            make.right.equalToSuperview().offset(-MetricGlobal.margin / 2)
        }
        
        return view
    }
}

