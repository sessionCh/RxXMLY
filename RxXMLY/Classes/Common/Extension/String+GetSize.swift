//
//  UIColor+HexColor.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/14.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

extension String {
    
    // MARK:- 获取字符串大小
    func getSize(fontSize: CGFloat) -> CGSize {
        let str = self as NSString
        
        let size = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT))
        return str.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size
    }
    
    // MARK:- 获取字符串大小
    func getSize(font: UIFont) -> CGSize {
        let str = self as NSString
        
        let size = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT))
        return str.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil).size
    }
}
