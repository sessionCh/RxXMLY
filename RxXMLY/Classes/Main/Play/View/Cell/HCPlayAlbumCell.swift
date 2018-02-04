//
//  HCPlayAlbumCell.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/2.
//  Copyright © 2018年 sessionCh. All rights reserved.
//  订阅专辑

import UIKit
import ReusableKit

// MARK:- 常量
fileprivate struct Metric {
    
    static let cellHeight: CGFloat = 80.0
}

class HCPlayAlbumCell: UITableViewCell {
    
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var subTitleLab: UILabel!
    @IBOutlet weak var albumView: UIView!
    @IBOutlet weak var albumLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        initEnableMudule()
    }
}

// MARK:- 初始化
extension HCPlayAlbumCell {
    
    func initUI() {
        
        // 设置样式
        self.albumView.layer.masksToBounds = true
        self.albumView.layer.cornerRadius = self.albumView.height / 2
        self.albumView.backgroundColor = kThemeMistyRoseColor
        self.albumLab.textColor = kThemeTomatoColor
        
        // 初始化
        self.iconImg.image = UIImage(named: "favicon")
        self.titleLab.text = "每天听见吴晓波·第二季"
        self.subTitleLab.text = "6.3万人订阅"
        self.albumLab.text = "订阅专辑"
    }
    
    static func cellHeight() -> CGFloat {
        
        return Metric.cellHeight
    }
}

// MARK:- 协议组件
extension HCPlayAlbumCell: HCCellStyleable {
    
    // MARK:- 协议组件
    private func initEnableMudule() {
        
        // 横线
        _ = bottomLine(style: .margin)
    }
}

