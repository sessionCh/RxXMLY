

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
    
    // MARK:- 成功回调
    typealias AddBlock = (_ isPlay: Bool)->Void
    var playBtnClickedBlock: AddBlock? = {
        (_) in return
    }

    var isPlay: Variable<Bool> = Variable(false)                // 播放状态

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

        // 绑定事件
        isPlay.asObservable().subscribe(onNext: { [weak self] beel in
            
            guard let `self` = self else { return }
            // 更新播放状态
            self.updatePlayStatus(isPlay: beel)
            // 同时回调处理
            self.playBtnClickedBlock?(beel)
            
        }).disposed(by: rx.disposeBag)

        // 点击事件
        contentView.rx.tapGesture().when(.recognized).subscribe({ [weak self] _ in
            
            guard let `self` = self else { return }
            self.isPlay.value = !self.isPlay.value
            
        }).disposed(by: rx.disposeBag)
    }
    
    // MARK:- 更新UI
    private func updatePlayStatus(isPlay: Bool) {
        
        if isPlay {
            
            self.title.text = "播放中"
            self.leftImg.image = UIImage(named: "playpage_icon_suspend")
            self.rightImg.startAnimating()
            
        } else {
            self.title.text = "已停播"
            self.leftImg.image = UIImage(named: "playpage_icon_play")
            self.rightImg.stopAnimating()
        }
    }
}
