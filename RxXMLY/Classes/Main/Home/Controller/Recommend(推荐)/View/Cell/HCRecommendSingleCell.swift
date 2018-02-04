//
//  HCRecommendSingleswift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/17.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

fileprivate struct Metric {
    static let scale : CGFloat = 120 / 375
    static let column: CGFloat = 1
    static let margin : CGFloat = 5
}

public enum HCRecommendSingleType {
    case play
    case read
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
    
    // 下划线
    var bottomLine: UIView?

    var cellType: HCRecommendSingleType = .read
    
    var item: HCRecommendItemModel? { didSet { setItem() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.leftImgView.layer.masksToBounds = true
        self.leftImgView.layer.borderColor = kThemeGainsboroColor.cgColor
        self.leftImgView.layer.borderWidth = 0.6
        
        initEnableMudule()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setItem() {
        
        guard let item = self.item else { return }
        
        if cellType == .read {
            
            leftTopLab.text = item.title
            leftImgView.kf.setImage(with: URL(string: item.pic))
            leftBottomImgView1.image = UIImage(named: "album_play")
            leftBottomImgView2.isHidden = false
            leftCenterLab.text = item.subtitle
            
            leftBottomLab1.text = self.defaultPlaysCount(item.playsCount)
            leftBottomLab2.text = "\(item.tracksCount)集"
        } else {
            
            leftTopLab.text = item.title
            leftImgView.kf.setImage(with: URL(string: item.coverPath))
            leftBottomImgView1.image = UIImage(named: "dailylistening_icon_album")
            leftBottomImgView2.isHidden = true
            leftCenterLab.text = item.subtitle
            leftBottomLab1.text = "\(item.footnote)"
            leftBottomLab2.text = "" 
        }
        
        if item.isFinished == 0 {
            leftTopTipView.isHidden = true
            leftTopLabCons.constant = -leftTopTipLab.width - 5
        } else {
            leftTopTipView.isHidden = false
            leftTopTipView.backgroundColor = kThemeLimeGreenColor
            leftTopLabCons.constant = 5.0
            leftTopTipLab.text = "完结"
        }
    }
    
    private func defaultPlaysCount(_ playsCount: Int) -> String {
        if playsCount < 10000 {
            return "\(playsCount)"
        } else {
            let result = String(format: "%.1f万", Float(playsCount) / 10000.0)
            return result
        }
    }
    
    static func itemSize() -> CGSize {
        // 结合 FlowLayout 设置
        let width = kScreenW
        let height = width * Metric.scale
        
        return CGSize(width: width, height: height)
    }
}

extension HCRecommendSingleCell: HCCellStyleable {
    
    // MARK:- 协议组件
    private func initEnableMudule() {
        
        // 横线
        bottomLine = bottomLine(style: .marginLeft)
        bottomLine?.backgroundColor = kThemeLightGreyColor
    }
}
