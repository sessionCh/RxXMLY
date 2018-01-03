//
//  HCAccountLoginViewModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/3.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HCAccountLoginViewModel {

    let accountUseable: Driver<HCAccountLoginResult>
    let passwordUseable: Driver<HCAccountLoginResult>
    let loginBtnEnable: Driver<Bool>
    let loginResult: Driver<HCAccountLoginResult>

    init(input: (accountField: UITextField, passwordField: UITextField, loginBtn: UIButton), service: HCAccountLoginService)  {
        
        let accountDriver = input.accountField.rx.text.orEmpty.asDriver()
        let passwordDriver = input.passwordField.rx.text.orEmpty.asDriver()
        let loginTapDriver = input.loginBtn.rx.tap.asDriver()
        
        accountUseable = accountDriver.skip(1).flatMapLatest { account in
            return service.validationAccount(account).asDriver(onErrorJustReturn: .failed(message: "连接service失败"))
        }
    
        passwordUseable = passwordDriver.skip(1).flatMapLatest { password in
            return service.validationPassword(password).asDriver(onErrorJustReturn: .failed(message: "连接service失败"))
        }
        
        let accountAndPassword = Driver.combineLatest(accountDriver, passwordDriver) {
            return ($0, $1)
        }
        
        loginBtnEnable = accountAndPassword.flatMap { (account, password) in
            return service.loginBtnEnable(account: account, password: password).asDriver(onErrorJustReturn: false)
        }
        
        loginResult = loginTapDriver.withLatestFrom(accountAndPassword).flatMapLatest{ (account, password)  in
            return service.login(account: account, password: password).asDriver(onErrorJustReturn: .failed(message: "连接service失败"))
        }
    }
}
