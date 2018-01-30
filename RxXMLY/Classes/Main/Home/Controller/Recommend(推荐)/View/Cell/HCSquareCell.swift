//
//  HCSquareCell.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/17.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

fileprivate struct Metric {
    
    static let width: CGFloat = 60
    static let height : CGFloat = 75
}

class HCSquareCell: UICollectionViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func itemMargin() -> CGFloat {
        
        return MetricGlobal.margin
    }
    
    static func itemSize() -> CGSize {
        
        return CGSize(width: Metric.width, height: Metric.height)
    }
}
