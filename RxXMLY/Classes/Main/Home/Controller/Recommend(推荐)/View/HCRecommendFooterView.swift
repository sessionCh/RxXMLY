//
//  HCRecommendFooterView.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/17.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

fileprivate struct Metric {
    
    static let defaultHeight : CGFloat = 55.0
}

class HCRecommendFooterView: UICollectionReusableView {

    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tipLab: UILabel!
    @IBOutlet weak var refreshBtn: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        topLine.isHidden = true
        topLine.backgroundColor = kThemeLightGreyColor
        bottomView.backgroundColor = kThemeGainsboroColor
    }
    
    static func footerSize() -> CGSize {
        
        return CGSize(width: kScreenW, height: Metric.defaultHeight)
    }
}
