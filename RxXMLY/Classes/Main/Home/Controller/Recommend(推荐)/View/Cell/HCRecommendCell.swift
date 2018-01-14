//
//  HCRecommendswift
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
    
    var item: HCRecommendItemModel? { didSet { setItem() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 0.5
    }
    
    func setItem() {
        
        guard let item = self.item else { return }
        
        imageView.kf.setImage(with: URL(string: item.pic))
        descLab.text = item.title
    }
    static func itemMargin() -> CGFloat {
        
        return MetricGlobal.margin
    }
    
    static func itemSize() -> CGSize {
        // 结合 FlowLayout 设置
        let width = (kScreenW - (Metric.column - 1 + 4) * itemMargin()) / Metric.column
        let height = width * Metric.scale
        
        return CGSize(width: width, height: height)
    }
}
