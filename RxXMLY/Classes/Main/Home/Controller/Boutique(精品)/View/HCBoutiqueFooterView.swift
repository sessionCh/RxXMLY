//
//  HCBoutiqueFooterView.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/15.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit
import ReusableKit

fileprivate struct Metric {
    
    static let defaultHeight : CGFloat = 10.0
}

class HCBoutiqueFooterView: UICollectionReusableView, NibLoadable {

    override func awakeFromNib() {
        super.awakeFromNib()        
    }
    
    static func defaultHeaderSize() -> CGSize {
        
        return CGSize(width: kScreenW, height: Metric.defaultHeight)
    }
}
