
//
//  HCURLNavigatorManager.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/10.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit
import URLNavigator

let navigatorShareInstance = HCURLNavigatorManager.shareInstance

class HCURLNavigatorManager {
    
    let navigator = Navigator()
    
    static let shareInstance = HCURLNavigatorManager()
    private init() {
        navigator.register("myapp://login") { (_, _, _) in
            return HCBaseNavigationController(rootViewController: HCLoginViewController())
        }
        navigator.register("myapp://setting") { (_, _, _) in
            return HCSettingViewController()
        }
    }
}
