//
//  HCNavMessageable.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/14.
//  Copyright © 2017年 sessionCh. All rights reserved.
//  消息按钮

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

protocol HCNavMessageable {
    
}

extension HCNavMessageable where Self : UIViewController {
    
    func message(onNext: @escaping ()->Void) {
        
        let item = UIBarButtonItem(image: UIImage(named: "top_message_n"), style: .plain, target: nil, action: nil)
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

