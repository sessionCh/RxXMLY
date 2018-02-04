//
//  HCTableViewCell.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/8.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit
import Then
import SnapKit

// MARK:- 常量
fileprivate struct Metric {
    
    static let cellHeight: CGFloat = 49.0
    
    static let titleFontSize: CGFloat = 15.0
    static let descFontSize: CGFloat = 13.0
    static let lineHeight: CGFloat = 0.5
}

class HCSettingCell: UITableViewCell {
    
    // 下划线
    private var bottomLine: UIView?

    // 正常
    private var leftIcon: UIImageView?
    private var titleLab: UILabel?
    private var descriptionLab: UILabel?
    private var rightIcon: UIImageView?
    private var dotIcon: UIImageView?

    // 右侧录音
    private var rightRecordButton: UIButton?
    private var centerVerticalLine: UIView?
   
    // 右侧开关
    private var rightSwitch: UISwitch?

    // 右侧文本
    private var rightTextLab: UILabel?

    var model: HCSettingCellModel? { didSet { setModel() } }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initCellUI()
        initEnableMudule()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HCSettingCell {
    
    // MARK:- 自定义组件
    func initCellUI() {
        
        // 创建组件
        let view = UIView().then {
            $0.backgroundColor = .white
        }
        let leftIcon = UIImageView().then {
            $0.contentMode = .scaleAspectFit
        }
        let titleLab = UILabel().then {
            $0.textColor = kThemeBlackColor
            $0.font = UIFont.systemFont(ofSize: Metric.titleFontSize)
        }
        let descriptionLab = UILabel().then {
            $0.textColor = kThemeOrangeRedColor
            $0.font = UIFont.systemFont(ofSize: Metric.descFontSize)
        }
        let rightIcon = UIImageView().then {
            $0.contentMode = .scaleAspectFit
        }
        let dotIcon = UIImageView().then {
            $0.contentMode = .scaleAspectFit
        }
        
        // 录音按钮
        let centerVerticalLine = UIView().then {
            $0.backgroundColor = kThemeLightGreyColor
        }
        let rightRecordButton = UIButton().then {
            $0.contentMode = .scaleAspectFit
        }
        
        // 开关
        let rightSwitch = UISwitch().then {
            $0.isOn = false
        }
        
        // 文本
        let rightTextLab = UILabel().then {
            $0.textColor = kThemeLightGreyColor
            $0.font = UIFont.systemFont(ofSize: Metric.descFontSize)
        }
        
        // 添加组件
        view.addSubview(leftIcon)
        view.addSubview(titleLab)
        view.addSubview(descriptionLab)
        view.addSubview(rightIcon)
        view.addSubview(dotIcon)
        
        view.addSubview(centerVerticalLine)
        view.addSubview(rightRecordButton)
        view.addSubview(rightSwitch)
        view.addSubview(rightTextLab)

        self.addSubview(view)
        
        // 赋值
        self.leftIcon = leftIcon
        self.titleLab = titleLab
        self.descriptionLab = descriptionLab
        self.rightIcon = rightIcon
        self.dotIcon = dotIcon
        
        self.centerVerticalLine = centerVerticalLine
        self.rightRecordButton = rightRecordButton
        self.rightSwitch = rightSwitch
        self.rightTextLab = rightTextLab
        
        // 左边
        leftIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(MetricGlobal.margin)
            make.centerY.equalToSuperview()
        }
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(leftIcon.snp.right).offset(MetricGlobal.padding)
            make.centerY.equalToSuperview()
        }

        // 右边
        rightIcon.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-MetricGlobal.margin)
            make.centerY.equalToSuperview()
        }
        dotIcon.snp.makeConstraints { (make) in
            make.right.equalTo(rightIcon.snp.left).offset(-MetricGlobal.padding / 2)
            make.centerY.equalToSuperview()
        }
        descriptionLab.snp.makeConstraints { (make) in
            make.right.equalTo(rightIcon.snp.left).offset(-MetricGlobal.padding / 2)
            make.centerY.equalToSuperview()
        }
        
        view.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        // 中间竖线
        centerVerticalLine.snp.makeConstraints { (make) in
            make.width.equalTo(Metric.lineHeight)
            make.top.equalToSuperview().offset(MetricGlobal.margin)
            make.bottom.equalToSuperview().offset(-MetricGlobal.margin)
            make.centerX.equalToSuperview()
        }
        // 录音按钮
        rightRecordButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-MetricGlobal.margin)
            make.centerY.equalToSuperview()
        }
        // 开关
        rightSwitch.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-MetricGlobal.margin)
            make.centerY.equalToSuperview()
        }
        // 文本
        rightTextLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-MetricGlobal.margin)
            make.centerY.equalToSuperview()
        }
    }

    // MARK:- Setter
    func setModel() {
        
        // 样式调整部分
        let cellType = model?.cellType ?? .normal
        switch cellType {
        case .normal:
            self.rightIcon?.isHidden = false
            self.descriptionLab?.isHidden = false

            self.rightSwitch?.isHidden = true
            self.rightTextLab?.isHidden = true
            self.rightRecordButton?.isHidden = true
            break
        case .rightRecordButton:
            self.rightIcon?.isHidden = true
            self.descriptionLab?.isHidden = true

            self.rightSwitch?.isHidden = true
            self.rightTextLab?.isHidden = true
            self.rightRecordButton?.isHidden = false
            
            break
        case .rightSwitch:
            
            // 设置开关
            if case let HCSettingCellType.rightSwitch(isOn) = cellType {
                self.rightSwitch?.isOn = isOn
            }

            self.rightIcon?.isHidden = true
            self.descriptionLab?.isHidden = true
            
            self.rightSwitch?.isHidden = false
            self.rightTextLab?.isHidden = true
            self.rightRecordButton?.isHidden = true
            break
        case .rightTextLab:
            self.rightIcon?.isHidden = true
            self.descriptionLab?.isHidden = true
            
            self.rightSwitch?.isHidden = true
            self.rightTextLab?.isHidden = false
            self.rightRecordButton?.isHidden = true
            break
        }
        
        self.centerVerticalLine?.isHidden = self.rightRecordButton?.isHidden ?? true
        
        // 显示部分
        if let leftIcon = model?.leftIcon {
            self.leftIcon?.image = UIImage(named: leftIcon)
        }
        if let title = model?.title {
            self.titleLab?.text = title
        }
        if let description = model?.description {
            self.descriptionLab?.text = description
        }
        if self.rightIcon?.isHidden == false, let rightIcon = model?.rightIcon {
            self.rightIcon?.image = UIImage(named: rightIcon)
        }
        if let dotIcon = model?.dotIcon {
            self.dotIcon?.image = UIImage(named: dotIcon)
        } 
        
        if let isHiddenBottomLine = model?.isHiddenBottomLine {
            self.bottomLine?.isHidden = isHiddenBottomLine
        }
        
        if self.rightRecordButton?.isHidden == false, let rightIcon = model?.rightIcon {
            self.rightRecordButton?.setBackgroundImage(UIImage(named: rightIcon), for: .normal)
        }

        if self.rightTextLab?.isHidden == false, let description = model?.description {
            self.rightTextLab?.text = description
        }
    }

    static func cellHeight() -> CGFloat {
        
        return Metric.cellHeight
    }
}

extension HCSettingCell: HCCellStyleable {

    // MARK:- 协议组件
    private func initEnableMudule() {
   
        // 横线
        bottomLine = bottomLine(style: .marginLeft)
    }
}
