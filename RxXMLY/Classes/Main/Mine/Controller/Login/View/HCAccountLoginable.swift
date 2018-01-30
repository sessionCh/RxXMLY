//
//  HCTextField.swift
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

// MARK:- 事件
struct AccountLoginEvent {
    
    // MARK:- 事件类型
    enum AccountLoginType {
        
        case login
        case forget
        case weixin
        case weibo
        case qq
    }

    var type: AccountLoginType
    var title: String?
    
    init(type: AccountLoginType, title: String?) {
     
        self.type = type
        self.title = title
    }
}

fileprivate struct Metric {
    
    static let tipBtnWidth: CGFloat = 40.0
    static let borderWidth: CGFloat = 1.0
    static let cornerRadius: CGFloat = 3.0

    static let fontSize = UIFont.systemFont(ofSize: 18)
    
    static let loginBtnHeight: CGFloat = 40.0
    static let loginBtnFontSize = UIFont.systemFont(ofSize: 16)
    static let forgetFontSize = UIFont.systemFont(ofSize: 13)
    static let loginBtnTitle = "登录"
    static let forgetBtnTitle = "忘记密码？"
    static let accountLeftTip = "+86"
    static let accountPlaceholder = "请输入手机号/邮箱"
    static let passswordPlaceholder = "请输入密码"
}

protocol HCAccountLoginable {
    
}

// MARK:- 自定义组件
extension HCAccountLoginable where Self : HCAccountLoginViewController {

    
    // MARK:- 其他登录方式
    func initOtherLoginView(onNext: @escaping (_ event: AccountLoginEvent)->Void) -> UIView {
        
        // 创建
        let otherLoginView = HCOtherLoginModeView.loadFromNib()
        
        otherLoginView.weixinBtn.rx.tap.do(onNext: {
            onNext(AccountLoginEvent.init(type: .weixin, title: "微信登陆"))
        }).subscribe().disposed(by: rx.disposeBag)
        
        otherLoginView.weiboBtn.rx.tap.do(onNext: {
            onNext(AccountLoginEvent.init(type: .weibo, title: "微博登陆"))
        }).subscribe().disposed(by: rx.disposeBag)
        
        otherLoginView.qqBtn.rx.tap.do(onNext: {
            onNext(AccountLoginEvent.init(type: .qq, title: "QQ登陆"))
        }).subscribe().disposed(by: rx.disposeBag)
        
        return otherLoginView
    }
    
    // MARK:- 登录按钮部分
    func initLoginBtnView(onNext: @escaping (_ event: AccountLoginEvent)->Void) -> (UIView, UIButton) {
        
        // 创建
        let btnView = UIView().then {
            $0.backgroundColor = kThemeWhiteColor
        }
        
        let loginBtn = UIButton().then {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = Metric.cornerRadius
            $0.setBackgroundImage(UIImage.color(kThemeTomatoColor), for: .normal)
            $0.titleLabel?.font = Metric.loginBtnFontSize
            $0.setTitleColor(kThemeWhiteColor, for: .normal)
            $0.setTitle(Metric.loginBtnTitle, for: .normal)
            $0.rx.tap.do(onNext: {
                onNext(AccountLoginEvent.init(type: .login, title: "登陆按钮"))
            }).subscribe().disposed(by: rx.disposeBag)
        }
        
        let forgetBtn = UIButton().then {
            $0.setTitleColor(kThemeTomatoColor, for: .normal)
            $0.setTitle(Metric.forgetBtnTitle, for: .normal)
            $0.titleLabel?.font = Metric.forgetFontSize
            $0.rx.tap.do(onNext: {
                onNext(AccountLoginEvent.init(type: .forget, title: "忘记密码"))
            }).subscribe().disposed(by: rx.disposeBag)
        }
        
        // 添加
        btnView.addSubview(loginBtn)
        btnView.addSubview(forgetBtn)
        
        // 布局
        loginBtn.snp.makeConstraints { (make) in
            
            make.left.right.top.equalToSuperview()
            make.height.equalTo(Metric.loginBtnHeight)
        }
        
        forgetBtn.snp.makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp.bottom).offset(MetricGlobal.margin)
            make.right.equalTo(loginBtn.snp.right)
            if let width = forgetBtn.titleLabel?.text?.getSize(font: Metric.forgetFontSize).width {
                make.width.equalTo(width)
            }
            make.height.equalTo(30)
            make.bottom.equalToSuperview().offset(-MetricGlobal.margin)
        }
        
        return (btnView, loginBtn)
    }
    
    // MARK:- 账号输入框
    func initAccountField(onNext: @escaping ()->Void) -> UITextField {
     
        let field = UITextField().then {
            $0.layer.masksToBounds = true
            $0.layer.borderColor = kThemeGainsboroColor.cgColor
            $0.layer.borderWidth = Metric.borderWidth
            $0.layer.cornerRadius = Metric.cornerRadius
            $0.borderStyle = .none
            $0.leftViewMode = .always
            $0.leftView = self.accountLeftView()
            $0.placeholder = Metric.accountPlaceholder
        }
        
//        // 输入内容 校验
//        let fieldObservable = field.rx.text.skip(1).throttle(0.75, scheduler: MainScheduler.instance).map { (input: String?) -> Bool in
//            guard let input  = input else { return false }
//            HCLog("\(input)")
//            return HCInputValidator.isValidEmail(email: input)
//        }

//        fieldObservable.map { (valid: Bool) -> UIColor in
//            let color = valid ? kThemeGainsboroColor : kThemeOrangeRedColor
//            return color
//        }.subscribe(onNext: { (color) in
//            field.layer.borderColor = color.cgColor
//        }).disposed(by: rx.disposeBag)
        
        return field
    }
    
    // MARK:- 密码输入框
    func initPasswordField(onNext: @escaping ()->Void) -> UITextField {

        let field = UITextField().then {
            $0.layer.masksToBounds = true
            $0.layer.borderColor = kThemeGainsboroColor.cgColor
            $0.layer.borderWidth = Metric.borderWidth
            $0.layer.cornerRadius = Metric.cornerRadius
            $0.isSecureTextEntry = true
            $0.borderStyle = .none
            $0.leftViewMode = .always
            $0.leftView = self.passwordLeftView()
            $0.placeholder = Metric.passswordPlaceholder
        }
        
//        // 输入内容 校验
//        let fieldObservable = field.rx.text.skip(1).throttle(0.75, scheduler: MainScheduler.instance).map { (input: String?) -> Bool in
//            guard let input  = input else { return false }
//            HCLog("\(input)")
//            return HCInputValidator.isvalidationPassword(password: input)
//        }
        
//        fieldObservable.map { (valid: Bool) -> UIColor in
//            let color = valid ? kThemeGainsboroColor : kThemeOrangeRedColor
//            return color
//            }.subscribe(onNext: { (color) in
//                field.layer.borderColor = color.cgColor
//            }).disposed(by: rx.disposeBag)

        return field
    }

    // MARK:- 账号输入框 左视图
    private func accountLeftView() -> UIView {
        
        let leftView = UIView().then {
            $0.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        }
        
        let tipLab = UILabel().then {
            $0.textAlignment = .center
            $0.font = Metric.fontSize
            $0.text = Metric.accountLeftTip
        }
        
        let tipBtn = UIButton().then {
            $0.contentMode = .scaleAspectFit
            $0.isUserInteractionEnabled = false
            $0.setImage(UIImage(named: "live_ic_arrow_right"), for: .normal)
            // 旋转90度
            $0.transform = CATransform3DGetAffineTransform(CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1))
        }
        
        let lineView = UIView().then {
            $0.backgroundColor = kThemeGainsboroColor
        }
        
        // 添加
        leftView.addSubview(tipLab)
        leftView.addSubview(tipBtn)
        leftView.addSubview(lineView)
        
        tipLab.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(tipBtn.snp.left)
        }
        
        tipBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(Metric.tipBtnWidth)
            make.right.equalTo(lineView.snp.left)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-MetricGlobal.margin)
            make.top.equalToSuperview().offset(MetricGlobal.margin)
            make.bottom.equalToSuperview().offset(-MetricGlobal.margin)
            make.width.equalTo(Metric.borderWidth)
        }
        
        return leftView
    }
    
    // MARK:- 密码输入框 左视图
    private func passwordLeftView() -> UIView {
        
        let leftView = UIView().then {
            $0.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        }
        
        let tipBtn = UIButton().then {
            $0.contentMode = .scaleAspectFit
            $0.isUserInteractionEnabled = false
            $0.setImage(UIImage(named: "registerAndLogin_password_textField"), for: .normal)
        }
        
        // 添加
        leftView.addSubview(tipBtn)
        
        tipBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(MetricGlobal.margin)
            make.right.equalToSuperview().offset(-MetricGlobal.margin)
            make.width.equalTo(Metric.tipBtnWidth)
        }
        
        return leftView
    }
}
