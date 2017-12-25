//
//  HCNavSettingable.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/14.
//  Copyright © 2017年 sessionCh. All rights reserved.
//  设置按钮

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

protocol HCNavSettingable {
    
}

extension HCNavSettingable where Self : UIViewController {
    
    func setting(onNext: @escaping ()->Void) {
        
        let item = UIBarButtonItem(image: UIImage(named: "meSetNor"), style: .plain, target: nil, action: nil)
        item.rx.tap.do(onNext: {
            onNext()
        }).subscribe().disposed(by: rx.disposeBag)
        
        if (navigationItem.leftBarButtonItems?.count ?? 0) == 0 {
            navigationItem.leftBarButtonItems = [item]
        } else {
            var items: [UIBarButtonItem] = [] + navigationItem.leftBarButtonItems!
            items.append(item)
            navigationItem.leftBarButtonItems = items
        }
    }
}

