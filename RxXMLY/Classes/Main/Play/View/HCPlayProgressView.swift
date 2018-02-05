//
//  HCPlayProgressView.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/24.
//  Copyright © 2018年 sessionCh. All rights reserved.
//  播放进度条

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxGesture

class HCPlayProgressView: UIView, NibLoadable {
    
    @IBOutlet weak var progressView: UIView!
    
    @IBOutlet weak var trackView: UIView!
    @IBOutlet weak var leftDot: UIView!
    @IBOutlet weak var rightDot: UIView!
    @IBOutlet weak var sliderSuperView: UIView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var leftLab: UILabel!
    @IBOutlet weak var rightLab: UILabel!
    @IBOutlet weak var sliderWidthCons: NSLayoutConstraint!


    private var sliderOriginWidth: CGFloat = 0.0
    private var sliderMinWidth: CGFloat = 0.0
    private var sliderMaxWidth: CGFloat = 0.0
    
    private var sliderMinValue: TimeInterval = 0.0         // 单位秒
    private var sliderMaxValue: TimeInterval = 300.0       // 单位秒
    private var sliderValue: Variable<TimeInterval> = Variable(0.0)

    override func awakeFromNib() {
        super.awakeFromNib()
    
        initUI()
        bindUI()
    }
}

// MARK:- 初始化
extension HCPlayProgressView {
    
    // MARK:- 初始化
    private func initUI() {
    
        // 设置样式
        sliderView.layer.masksToBounds = true
        sliderView.layer.cornerRadius = sliderView.width / 2
        sliderView.backgroundColor = kThemeTomatoColor
        leftLab.textColor = kThemeTomatoColor
        rightLab.textColor = kThemeTomatoColor
        leftDot.layer.masksToBounds = true
        leftDot.layer.cornerRadius = leftDot.width / 2
        rightDot.layer.masksToBounds = true
        rightDot.layer.cornerRadius = leftDot.width / 2
        
        // 添加手势
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(HCPlayProgressView.panGesture(sender:)))
        sliderSuperView.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HCPlayProgressView.tapGesture(sender:)))
        tapView.addGestureRecognizer(tapGesture)
        
        // 设置初始值
        sliderMinValue = 0
        sliderMaxValue = 3661
        sliderValue.value = 1000
        
        // 设置初始值
        sliderMinWidth = 0.0
        sliderMaxWidth = progressView.width
        sliderOriginWidth = CGFloat((sliderValue.value - sliderMinValue) / (sliderMaxValue - sliderMinValue)) * (sliderMaxWidth - sliderMinWidth) + sliderMinWidth
        
        sliderWidthCons.constant = sliderOriginWidth

        leftLab.text = HCTimeTools.formatPlayTime(secounds: sliderMinValue)
        rightLab.text = HCTimeTools.formatPlayTime(secounds: sliderMaxValue)
    }
    
    // MARK:- 绑定事件
    private func bindUI() {
        
        sliderValue.asObservable().subscribe { [weak self] (_) in
            
            guard let `self` = self else { return }
            self.leftLab.text = HCTimeTools.formatPlayTime(secounds: self.sliderValue.value)
    
        }.disposed(by: rx.disposeBag)
    }
}

// MARK:- 事件处理
extension HCPlayProgressView {
    
    // MARK:- 拖动滑块
    @objc func panGesture(sender: UIPanGestureRecognizer) {

        if sender.state == .began {
            
            sliderOriginWidth = sliderWidthCons.constant
        } else if sender.state == .changed {
            
            let translationX = sender.translation(in: progressView).x
            HCLog("translationX \(translationX)")
            
            let newSliderWidth = sliderOriginWidth + translationX
            if newSliderWidth <= sliderMinWidth {
                sliderWidthCons.constant = sliderMinWidth
            } else if newSliderWidth >= sliderMaxWidth {
                sliderWidthCons.constant = sliderMaxWidth
            } else {
                sliderWidthCons.constant = newSliderWidth
            }
            
            sliderValue.value = Double(sliderWidthCons.constant / sliderMaxWidth) * (sliderMaxValue - sliderMinValue) + sliderMinValue

        } else if sender.state == .ended {
            
            sliderValue.value = Double(sliderWidthCons.constant / sliderMaxWidth) * (sliderMaxValue - sliderMinValue) + sliderMinValue
        }
    }
    
    // MARK:- 点击滑条
    @objc func tapGesture(sender: UITapGestureRecognizer) {
        
        let locationX = sender.location(in: tapView).x
        HCLog("locationX \(locationX)")
        
        let newSliderWidth = locationX
        if newSliderWidth <= sliderMaxWidth {
            sliderWidthCons.constant = newSliderWidth
        } else {
            sliderWidthCons.constant = sliderMaxWidth
        }
        
        sliderValue.value = Double(sliderWidthCons.constant / sliderMaxWidth) * (sliderMaxValue - sliderMinValue) + sliderMinValue
    }
}
