
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
    
    static let lineHeight: CGFloat = 0.5    // 细线高度
}

public enum HCBottomLineStyle : Int {
    case none                   // 无横线
    case full                   // 充满
    case margin                 // 有左边距
}

protocol HCCellStyleable {
    
}

extension HCCellStyleable where Self : UITableViewCell {
    
    // MARK:- 横线
    func bottomLine(style: HCBottomLineStyle) -> UIView {
        
        // 创建组件
        let bottomLine = UIView().then {
            $0.backgroundColor = kThemeLightGreyColor
        }
        
        // 添加组件
        self.addSubview(bottomLine)

        // 添加约束
        bottomLine.snp.makeConstraints { (make) in
            make.height.equalTo(Metric.lineHeight)
            make.left.equalTo(MetricGlobal.margin * 2)
            make.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-Metric.lineHeight)
        }
        
        // 调整样式
        switch style {
        case .none:
            bottomLine.isHidden = true
            break
            
        case .margin:
            bottomLine.isHidden = false
            bottomLine.snp.updateConstraints({ (make) in
                make.left.equalTo(MetricGlobal.margin * 2)
            })
            break
            
        case .full:
            bottomLine.isHidden = false
            bottomLine.snp.updateConstraints({ (make) in
                make.left.equalTo(0)
            })
            break
        }
        
        return bottomLine
    }
}


