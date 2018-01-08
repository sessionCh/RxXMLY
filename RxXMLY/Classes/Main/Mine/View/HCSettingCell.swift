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
    
    static let titleFontSize: CGFloat = 15.0
    static let descFontSize: CGFloat = 13.0
}

class HCSettingCell: UITableViewCell {
    
    private var bottomLine: UIView?

    private var leftIcon: UIImageView?
    private var titleLab: UILabel?
    private var descriptionLab: UILabel?
    private var rightIcon: UIImageView?
    private var dotIcon: UIImageView?
    
    var model: HCSettingCellModel? { didSet { setModel() } }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initEnableMudule()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HCSettingCell {
    
    // MARK:- Setter
    func setModel() {
        
        if let leftIcon = model?.leftIcon {
            self.leftIcon?.image = UIImage(named: leftIcon)
        }
        if let title = model?.title {
            self.titleLab?.text = title
        }
        if let description = model?.description {
            self.descriptionLab?.text = description
        }
        if let rightIcon = model?.rightIcon {
            self.rightIcon?.image = UIImage(named: rightIcon)
        }
        if let dotIcon = model?.dotIcon {
            self.dotIcon?.image = UIImage(named: dotIcon)
        }
        
        if let isHiddenBottomLine = model?.isHiddenBottomLine {
            self.bottomLine?.isHidden = isHiddenBottomLine
        }
    }
}

extension HCSettingCell: HCCellStyleable {

    // MARK:- 协议组件
    private func initEnableMudule() {
        
        // 设置
        settingCell()
        
        // 横线
        bottomLine = bottomLine(style: .margin)
    }
    
    // MARK:- 自定义组件
    func settingCell() {
        
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
            $0.textColor = kThemeGreyColor
            $0.font = UIFont.systemFont(ofSize: Metric.descFontSize)
        }
        let rightIcon = UIImageView().then {
            $0.contentMode = .scaleAspectFit
        }
        let dotIcon = UIImageView().then {
            $0.contentMode = .scaleAspectFit
        }
        
        // 添加组件
        view.addSubview(leftIcon)
        view.addSubview(titleLab)
        view.addSubview(descriptionLab)
        view.addSubview(rightIcon)
        view.addSubview(dotIcon)
        
        self.addSubview(view)
        
        // 赋值
        self.leftIcon = leftIcon
        self.titleLab = titleLab
        self.descriptionLab = descriptionLab
        self.rightIcon = rightIcon
        self.dotIcon = dotIcon
        
        // 左边
        leftIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(MetricGlobal.margin)
            make.centerY.equalToSuperview()
        }
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(leftIcon.snp.right).offset(MetricGlobal.padding)
            make.centerY.equalToSuperview()
        }
        descriptionLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right).offset(MetricGlobal.padding)
            make.centerY.equalToSuperview()
        }
        
        // 右边
        rightIcon.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-MetricGlobal.margin)
            make.centerY.equalToSuperview()
        }
        dotIcon.snp.makeConstraints { (make) in
            make.right.equalTo(rightIcon.snp.left).offset(-MetricGlobal.padding)
            make.centerY.equalToSuperview()
        }
        
        view.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

// MARK:- 设置单元格 数据模型
public struct HCSettingCellModel {
    
    var leftIcon: String?
    var title: String?
    var description: String?
    var dotIcon: String?
    var rightIcon: String?
    
    var isHiddenBottomLine: Bool? = false
    
    init(leftIcon: String?, title: String?, description: String?, dotIcon: String?, rightIcon: String?) {
        
        self.leftIcon = leftIcon
        self.title = title
        self.description = description
        self.rightIcon = rightIcon
        self.dotIcon = dotIcon
    }
    
    init(leftIcon: String?, title: String?, description: String?, dotIcon: String?, rightIcon: String?, isHiddenBottomLine: Bool) {
        
        self.leftIcon = leftIcon
        self.title = title
        self.description = description
        self.rightIcon = rightIcon
        self.dotIcon = dotIcon
        
        self.isHiddenBottomLine = isHiddenBottomLine
    }
}

