//
//  HCPlayRecommendCell.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/6.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ReusableKit
import NSObject_Rx

fileprivate struct Metric {
    
    static let scale : CGFloat = 120 / 375
    static let column: CGFloat = 1
    static let margin : CGFloat = 5
}

public enum HCPlayRecommendType {
    case play
    case read
}

class HCPlayRecommendCell: UITableViewCell {
    
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
    var albumsInfoModel: Variable<HCAssociationAlbumsInfoModel?> = Variable(nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initEnableMudule()
        initUI()
        bindUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK:- 初始化
extension HCPlayRecommendCell {
    
    private func initUI() {
        
        self.leftImgView.layer.masksToBounds = true
        self.leftImgView.layer.borderColor = kThemeGainsboroColor.cgColor
        self.leftImgView.layer.borderWidth = 0.6
    }
    
    private func bindUI() {
        
        albumsInfoModel.asObservable().subscribe(onNext: { [weak self] model in
            
            guard let `self` = self else { return }
            
            self.leftTopLab.text = model?.title
            if let coverMiddle = model?.coverMiddle {
                self.leftImgView.kf.setImage(with: URL(string: coverMiddle))
            }
            self.leftBottomImgView1.image = UIImage(named: "album_play")
            self.leftBottomImgView2.isHidden = false
            if let intro = model?.intro {
                self.leftCenterLab.text = intro
            }
            
            self.leftBottomLab1.text = self.defaultPlaysCount(524300)
            if let discountedPrice = model?.discountedPrice {
                self.leftBottomLab2.text = "\(discountedPrice)集"
            }

        }).disposed(by: rx.disposeBag)
    }
    
    private func defaultPlaysCount(_ playsCount: Int) -> String {
        if playsCount < 10000 {
            return "\(playsCount)"
        } else {
            let result = String(format: "%.1f万", Float(playsCount) / 10000.0)
            return result
        }
    }
    
    static func cellHeight() -> CGFloat {
        // 结合 FlowLayout 设置
        let width = kScreenW
        let height = width * Metric.scale
        
        return height
    }
}

extension HCPlayRecommendCell: HCCellStyleable {
    
    // MARK:- 协议组件
    private func initEnableMudule() {
        
        // 横线
        bottomLine = bottomLine(style: .marginLeft)
        bottomLine?.backgroundColor = kThemeLightGreyColor
    }
}
