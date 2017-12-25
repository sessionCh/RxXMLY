//
//  HCNavSearchable.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/14.
//  Copyright © 2017年 sessionCh. All rights reserved.
//  搜索图标

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

protocol HCNavSearchable {
    
}

extension HCNavSearchable where Self : UIViewController {
    
    func search(onNext: @escaping ()->Void) {
        
        let item = UIBarButtonItem(image: UIImage(named: "icon_search_n"), style: .plain, target: nil, action: nil)
        item.rx.tap.do(onNext: {
            onNext()
        }).subscribe().disposed(by: rx.disposeBag)
        
        if (navigationItem.rightBarButtonItems?.count ?? 0) == 0 {
            navigationItem.rightBarButtonItems = [item]
        } else {
            var items: [UIBarButtonItem] = [] + navigationItem.rightBarButtonItems!
            items.append(item)
            navigationItem.rightBarButtonItems = items
        }
    }
}
