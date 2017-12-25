//
//  UIView+Corner.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/15.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK:- 裁剪圆角
    func clipCorner(direction: UIRectCorner, radius: CGFloat) {
        
        let cornerSize = CGSize(width: radius, height: radius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
}
