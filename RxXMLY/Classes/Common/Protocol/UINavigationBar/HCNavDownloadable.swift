//
//  HCNavDownloadable.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/14.
//  Copyright © 2017年 sessionCh. All rights reserved.
//  下载按钮

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

protocol HCNavDownloadable {
    
}

extension HCNavDownloadable where Self : UIViewController {
    
    func download(onNext: @escaping ()->Void) {
        
        let item = UIBarButtonItem(image: UIImage(named: "top_download_n"), style: .plain, target: nil, action: nil)
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
