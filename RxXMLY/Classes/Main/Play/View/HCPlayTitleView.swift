

//
//  HCPlayTitleView.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/5.
//  Copyright © 2018年 sessionCh. All rights reserved.
//  标题视图

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxDataSources
import ReusableKit
import NSObject_Rx


class HCPlayTitleView: UIView, NibLoadable {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var rightImg: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    
    private var isPlay: Bool = false    // 播放状态

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        bindUI()
    }
}

// MARK:- 初始化
extension HCPlayTitleView {
    
    // MARK:- 初始化
    private func initUI() {

        self.rightImg.animationImages = [UIImage(named: "playpage_icon_dynamic_rhythm_p1")!, UIImage(named: "playpage_icon_dynamic_rhythm_p2")!, UIImage(named: "playpage_icon_dynamic_rhythm_p3")!]
        self.rightImg.animationDuration = 0.5
        self.rightImg.animationRepeatCount = 0
    }
    
    // MARK:- 绑定事件
    private func bindUI() {

        // 不起作用，暂时没处理
        self.contentView.rx.tapGesture().when(.recognized).subscribe({ [weak self] _ in
            guard let `self` = self else { return }
            
            self.isPlay = !self.isPlay
            // 更新UI
            self.updateUI()
            
        }).disposed(by: rx.disposeBag)
    }
    
    // MARK:- 更新UI
    private func updateUI() {
        
        if self.isPlay {
            
            self.title.text = "播放中"
            self.leftImg.image = UIImage(named: "playpage_icon_play")
            self.rightImg.startAnimating()
            
        } else {
            self.title.text = "已停播"
            self.leftImg.image = UIImage(named: "playpage_icon_suspend")
            self.rightImg.stopAnimating()
        }
    }
}
