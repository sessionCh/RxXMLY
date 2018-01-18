//
//  HCBoutiqueIndexCell.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/16.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit
import ReusableKit

fileprivate struct Metric {
    
    static let margin : CGFloat = 10
    static let height : CGFloat = 38
    static let column: CGFloat = 5
    static let singleColumn: CGFloat = 4.5
}

class HCBoutiqueIndexCell: UICollectionViewCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var bottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomLine.backgroundColor = kThemeOrangeRedColor
    }
    
    static func itemMargin() -> CGFloat {
        
        return Metric.margin
    }
    
    static func itemSize() -> CGSize {
        // 结合 FlowLayout 设置
        let width = (kScreenW - Metric.margin * (Metric.column - 1 + 3)) / Metric.column
        
        return CGSize(width: width, height: Metric.height)
    }
    
    static func singleItemSize() -> CGSize {
        // 结合 FlowLayout 设置
        let width = (kScreenW - Metric.margin * (Metric.singleColumn - 1 + 1.5)) / Metric.singleColumn
        
        return CGSize(width: width, height: Metric.height)
    }
}
