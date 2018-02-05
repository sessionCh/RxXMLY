//
//  HCTabbarPlayView.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/23.
//  Copyright © 2018年 sessionCh. All rights reserved.
//  播放按钮

import UIKit
import RxSwift
import RxCocoa
import Then

// MARK:- 常量
fileprivate struct Metric {
    
    static let width: CGFloat = 60.0    // 控件大小
    static let spaceWidth: CGFloat = 8.0    // 圆环间距
    static let iconWidth: CGFloat = Metric.width - Metric.spaceWidth * 2 + 2   // 播放按钮大小
}

class HCTabbarPlayView: UIView {

    var isPlay: Variable<Bool> = Variable(false)                // 播放状态

    // MARK:- 成功回调
    typealias AddBlock = (_ isPlay: Bool)->Void
    var playBtnClickedBlock: AddBlock? = {
        (_) in return
    }

    private let layerView = UIView().then {
        $0.layer.shadowColor = kThemeGreyColor.cgColor
        $0.layer.shadowOpacity = 0.8
        $0.layer.shadowOffset = CGSize(width: 0, height: -1)
        $0.layer.shadowRadius = 3
    }
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = kThemeWhiteColor
        $0.width = Metric.width
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = $0.width / 2        
    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "favicon")
        $0.width = Metric.width - Metric.spaceWidth * 2
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = $0.width / 2
        $0.layer.borderColor = kThemeGainsboroColor.cgColor
        $0.layer.borderWidth = 0.5
    }
    
    private let iconView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "toolbar_play_n")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
        bindUI()
        updatePlayStatus(isPlay: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HCTabbarPlayView {
    
    private func initUI() {
        
        backgroundView.addSubview(imageView)
        backgroundView.addSubview(iconView)
        
        let layerSubView = UIView()
        layerSubView.backgroundColor = kThemeWhiteColor
        layerSubView.layer.masksToBounds = true
        layerSubView.layer.cornerRadius = Metric.width / 2
        
        layerView.addSubview(layerSubView)

        self.addSubview(layerView)
        self.addSubview(backgroundView)

        layerView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(Metric.width)
        }
        
        layerSubView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(Metric.width / 5 * 4)
        }

        backgroundView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            let width = Metric.width - Metric.spaceWidth * 2
            make.width.height.equalTo(width)
            make.left.equalToSuperview().offset(Metric.spaceWidth)
            make.top.equalToSuperview().offset(Metric.spaceWidth)
        }
        
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(Metric.iconWidth)
            make.left.equalToSuperview().offset(Metric.spaceWidth - 1)
            make.top.equalToSuperview().offset(Metric.spaceWidth - 1)
        }
    }
    
    // MARK:- 更新UI
    private func updatePlayStatus(isPlay: Bool) {
        
        if isPlay {
            self.iconView.image = UIImage(named: "toolbar_pause_n")
        } else {
            self.iconView.image = UIImage(named: "toolbar_play_n")
        }
    }

    private func bindUI() {
        
        // 绑定事件
        isPlay.asObservable().subscribe(onNext: { [weak self] beel in
            
            guard let `self` = self else { return }
            // 更新状态
            self.updatePlayStatus(isPlay: beel)
            // 回调处理
            self.playBtnClickedBlock?(self.isPlay.value)
            
        }).disposed(by: rx.disposeBag)

        // 点击事件
        self.rx.tapGesture().when(.recognized).subscribe({ [weak self]  _ in
            
            guard let `self` = self else { return }
            // 点击 进入 播放状态
            self.isPlay.value = true
            
        }).disposed(by: rx.disposeBag)
    }
    
    static func with() -> CGFloat {
        return Metric.width
    }
}
