//
//  HCRecommendCell.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

fileprivate struct Metric {
    static let scale : CGFloat = 18 / 13
    static let column: CGFloat = 3
    static let margin : CGFloat = 5
}

class HCRecommendCell: UICollectionViewCell {

    @IBOutlet weak var descLab: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 0.5
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
