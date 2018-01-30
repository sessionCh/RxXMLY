//
//  HCRecommendswift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

fileprivate struct Metric {
    
    static let margin : CGFloat = 10
    static let scale : CGFloat = 18 / 13
    static let column: CGFloat = 3
}

class HCRecommendCell: UICollectionViewCell {

    @IBOutlet weak var descLab: UILabel!
    @IBOutlet weak var iconBtn: UIButton!
    
    var item: HCRecommendItemModel? { didSet { setItem() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconBtn.layer.masksToBounds = true
        iconBtn.layer.borderColor = UIColor.lightGray.cgColor
        iconBtn.layer.borderWidth = 0.5
        iconBtn.addTarget(self, action: #selector(iconTouchDown(btn:)), for: .touchDown)
        iconBtn.addTarget(self, action: #selector(iconTouchUpInside(btn:)), for: .touchUpInside)
    }
    
    @objc func iconTouchDown(btn: UIButton?) {
        iconBtn.backgroundColor = kThemeOrangeRedColor
    }
    
    @objc func iconTouchUpInside(btn: UIButton?) {
        iconBtn.backgroundColor = kThemeWhiteColor
    }
    
    func setItem() {
        
        guard let item = self.item else { return }

        iconBtn.kf.setBackgroundImage(with: URL(string: item.pic), for: .normal)
        descLab.text = item.title
    }
    
    static func itemMargin() -> CGFloat {
        
        return Metric.margin
    }

    static func itemSize() -> CGSize {
        // 结合 FlowLayout 设置
        let width = (kScreenW - Metric.margin * (Metric.column - 1 + 3)) / Metric.column
        let height = width * Metric.scale
        
        return CGSize(width: width, height: height)
    }
}
