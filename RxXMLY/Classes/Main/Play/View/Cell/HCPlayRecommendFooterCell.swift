//
//  HCPlayRecommendFooterCell.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/6.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit

// MARK:- 常量
fileprivate struct Metric {
    
    static let cellHeight : CGFloat = 60.0
}

class HCPlayRecommendFooterCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func cellHeight() -> CGFloat {
        
        return Metric.cellHeight
    }
}
