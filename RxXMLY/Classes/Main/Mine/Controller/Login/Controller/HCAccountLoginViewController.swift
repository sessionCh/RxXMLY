//
//  HCAccountLoginViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/27.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit
import Then

// MARK:- 常量
fileprivate struct Metric {
    
    static let fieldHeight: CGFloat = 45.0
}

class HCAccountLoginViewController: HCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kThemeWhiteColor
        
        initTextField()
    }
}

// MARK:- 初始化
extension HCAccountLoginViewController: HCAccountLoginable {
    
    // MARK:- 初始化 登录 输入框
    private func initTextField() {

        // 创建 协议组件
        let accountField = initAccountField {
            
        }

        let passwordField = initPasswordField {
            
        }
        
        let loginBtnView = initLoginBtnView { type in
            
            if type == .login {
                HCLog("登录")
            } else if type == .forget {
                HCLog("忘记密码")
            }
        }

        // 布局
        accountField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(MetricGlobal.margin * 4)
            make.right.equalToSuperview().offset(-MetricGlobal.margin * 4)
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
    }
}
