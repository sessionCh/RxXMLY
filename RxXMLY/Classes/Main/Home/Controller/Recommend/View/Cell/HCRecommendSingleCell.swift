//
//  HCRecommendSingleCell.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/17.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

fileprivate struct Metric {
    static let scale : CGFloat = 90 / 375
    static let column: CGFloat = 1
    static let margin : CGFloat = 5
}

class HCRecommendSingleCell: UICollectionViewCell {

    @IBOutlet weak var leftTopLabCons: NSLayoutConstraint!
    @IBOutlet weak var leftImgView: UIImageView!
    @IBOutlet weak var leftTopTipView: UIView!
    @IBOutlet weak var leftTopTipLab: UILabel!
    @IBOutlet weak var leftTopLab: UILabel!
    @IBOutlet weak var leftCenterLab: UILabel!
    
    @IBOutlet weak var leftBottomImgView1: UIImageView!
    @IBOutlet weak var leftBottomImgView2: UIImageView!
    @IBOutlet weak var leftBottomLab1: UILabel!
    @IBOutlet weak var leftBottomLab2: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.leftImgView.layer.masksToBounds = true
        self.leftImgView.layer.borderColor = kThemeGainsboroSmokeColor.cgColor
        self.leftImgView.layer.borderWidth = 0.6
    }
    
    static func itemMargin() -> CGFloat {
        
        return Metric.margin
    }
    
    static func itemSize() -> CGSize {
        
        let width = (kScreenW - (Metric.column * 2 + 4) * itemMargin()) / Metric.column
        let height = width * Metric.scale
        
        return CGSize(width: width, height: height)
    }
}
