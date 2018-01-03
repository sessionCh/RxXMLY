//
//  HCAccountLoginViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/27.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import NSObject_Rx

// MARK:- 常量
fileprivate struct Metric {
    
    static let fieldHeight: CGFloat = 45.0
}

class HCAccountLoginViewController: HCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kThemeWhiteColor
        view.rx.tapGesture().do(onNext: { [weak self] _ in
            self?.view.endEditing(true)
        }).subscribe().disposed(by: rx.disposeBag)

        initTextField()
    }
}

// MARK:- 初始化
extension HCAccountLoginViewController: HCAccountLoginable {
    
    // MARK:- 初始化 登录 输入框
    private func initTextField() {

        // 创建 容器组件
        let scrollView = UIScrollView().then {
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }

        // 创建 协议组件
        let accountField = initAccountField { }
        let passwordField = initPasswordField { }
        let loginBtnView = initLoginBtnView { event in HCLog(event.title) }
        let otherLoginView = initOtherLoginView { event in HCLog(event.title) }
        
        // 添加
        view.addSubview(scrollView)
        scrollView.addSubview(accountField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginBtnView)
        scrollView.addSubview(otherLoginView)
        
        // 布局
        scrollView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(kScreenW)
        }

        accountField.snp.makeConstraints { (make) in
            if kScreenW <= 320 {
                make.left.equalToSuperview().offset(MetricGlobal.margin * 2)
            } else {
                make.left.equalToSuperview().offset(MetricGlobal.margin * 3)
            }
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(MetricGlobal.margin * 2)
            make.height.equalTo(Metric.fieldHeight)
        }

        passwordField.snp.makeConstraints { (make) in
            make.left.equalTo(accountField.snp.left)
            make.right.equalTo(accountField.snp.right)
            make.top.equalTo(accountField.snp.bottom).offset(MetricGlobal.margin * 2)
            make.height.equalTo(Metric.fieldHeight)
        }

        loginBtnView.snp.makeConstraints { (make) in
            make.left.equalTo(accountField.snp.left)
            make.right.equalTo(accountField.snp.right)
            make.top.equalTo(passwordField.snp.bottom).offset(MetricGlobal.margin * 2)
        }
        
        otherLoginView.snp.makeConstraints { (make) in
            
            if kScreenW <= 320 {
                make.left.equalTo(accountField.snp.left).offset(-MetricGlobal.margin * 1)
            } else {
                make.left.equalTo(accountField.snp.left).offset(-MetricGlobal.margin * 2)
            }
            make.centerX.equalToSuperview()
            make.top.equalTo(loginBtnView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}
