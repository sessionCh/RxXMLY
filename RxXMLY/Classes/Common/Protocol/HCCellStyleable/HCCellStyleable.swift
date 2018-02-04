
//
//  HCCellStyleable.swift
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
    
    static let margin: CGFloat = 10.0       // 边距
    static let lineHeight: CGFloat = 0.5    // 细线高度
}

public enum HCCellLineStyle : Int {
    case `default`                   // 无横线
    case none                   // 无横线
    case full                   // 充满
    case margin                 // 有左右边距
    case marginLeft             // 有左边距
    case marginRight            // 有右边距
}

protocol HCCellStyleable {
    
}

extension HCCellStyleable where Self : UITableViewCell {
    
    // MARK:- 横线
    func bottomLine(style: HCCellLineStyle) -> UIView {
        
        // 创建组件
        let bottomLine = UIView().then {
            $0.backgroundColor = kThemeLightGreyColor
        }
        
        // 添加组件
        self.addSubview(bottomLine)

        // 添加约束
        bottomLine.snp.makeConstraints { (make) in
            make.height.equalTo(Metric.lineHeight)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-Metric.lineHeight)
        }
        
        // 调整样式
        switch style {
        case .none:
            bottomLine.isHidden = true
            break
        case .full:
            bottomLine.isHidden = false
            bottomLine.snp.updateConstraints({ (make) in
                make.left.equalTo(0)
            })
            break
        case .margin:
            bottomLine.isHidden = false
            bottomLine.snp.updateConstraints({ (make) in
                make.left.equalTo(Metric.margin * 2)
                make.right.equalTo(-Metric.margin * 2)
            })
            break
        case .marginLeft:
            bottomLine.isHidden = false
            bottomLine.snp.updateConstraints({ (make) in
                make.left.equalTo(Metric.margin * 2)
            })
            break
        case .marginRight:
            bottomLine.isHidden = false
            bottomLine.snp.updateConstraints({ (make) in
                make.right.equalTo(-Metric.margin * 2)
            })
            break
        default:
            break
        }
        return bottomLine
    }
}

extension HCCellStyleable where Self : UICollectionViewCell {
    
    // MARK:- 横线
    func topLine(style: HCCellLineStyle) -> UIView {
        
        // 创建组件
        let topLine = UIView().then {
            $0.backgroundColor = kThemeLightGreyColor
        }
        
        // 添加组件
        self.addSubview(topLine)
        
        // 添加约束
        topLine.snp.makeConstraints { (make) in
            make.height.equalTo(Metric.lineHeight)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self.snp.top).offset(Metric.lineHeight)
        }
        
        // 调整样式
        switch style {
        case .none:
            topLine.isHidden = true
            break
        case .full:
            topLine.isHidden = false
            topLine.snp.updateConstraints({ (make) in
                make.left.equalTo(0)
            })
            break
        case .margin:
            topLine.isHidden = false
            topLine.snp.updateConstraints({ (make) in
                make.left.equalTo(Metric.margin * 2)
                make.right.equalTo(-Metric.margin * 2)
            })
            break
        case .marginLeft:
            topLine.isHidden = false
            topLine.snp.updateConstraints({ (make) in
                make.left.equalTo(Metric.margin * 2)
            })
            break
        case .marginRight:
            topLine.isHidden = false
            topLine.snp.updateConstraints({ (make) in
                make.right.equalTo(-Metric.margin * 2)
            })
            break
        default:
            break
        }
        return topLine
    }

    // MARK:- 横线
    func bottomLine(style: HCCellLineStyle) -> UIView {
        
        // 创建组件
        let bottomLine = UIView().then {
            $0.backgroundColor = kThemeLightGreyColor
        }
        
        // 添加组件
        self.addSubview(bottomLine)
        
        // 添加约束
        bottomLine.snp.makeConstraints { (make) in
            make.height.equalTo(Metric.lineHeight)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-Metric.lineHeight)
        }
        
        // 调整样式
        switch style {
        case .none:
            bottomLine.isHidden = true
            break
        case .full:
            bottomLine.isHidden = false
            bottomLine.snp.updateConstraints({ (make) in
                make.left.equalTo(0)
            })
            break
        case .margin:
            bottomLine.isHidden = false
            bottomLine.snp.updateConstraints({ (make) in
                make.left.equalTo(Metric.margin * 2)
                make.right.equalTo(Metric.margin * 2)
            })
            break
        case .marginLeft:
            bottomLine.isHidden = false
            bottomLine.snp.updateConstraints({ (make) in
                make.left.equalTo(Metric.margin * 2)
            })
            break
        case .marginRight:
            bottomLine.isHidden = false
            bottomLine.snp.updateConstraints({ (make) in
                make.right.equalTo(Metric.margin * 2)
            })
            break
        default:
            break
        }
        return bottomLine
    }
}

