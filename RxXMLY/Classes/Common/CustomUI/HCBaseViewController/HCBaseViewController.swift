//
//  HCBaseViewController.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/14.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class HCBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        HCLog("init: \(type(of: self))")

        view.backgroundColor = kThemeGainsboroColor
    }
    
    deinit {
        HCLog("deinit: \(type(of: self))")
    }
}

// MARK:- 事件 (部分页面失效)
extension HCBaseNavigationController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // 注销 键盘
        view.endEditing(true)
    }
}

