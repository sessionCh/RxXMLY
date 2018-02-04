//
//  Common.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/14.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

// 屏幕宽度
let kScreenH = UIScreen.main.bounds.height
// 屏幕高度
let kScreenW = UIScreen.main.bounds.width
//适配iPhoneX
let is_iPhoneX = (kScreenW == 375.0 && kScreenH == 812.0 ? true : false)
let kNavibarH: CGFloat = is_iPhoneX ? 88.0 : 64.0
let kTabbarH: CGFloat = is_iPhoneX ? 49.0+34.0 : 49.0
let kStatusbarH: CGFloat = is_iPhoneX ? 44.0 : 20.0
let iPhoneXBottomH: CGFloat = 34.0
let iPhoneXTopH: CGFloat = 24.0

// MARK:- 常量
struct MetricGlobal {
    static let padding: CGFloat = 10.0
    static let margin: CGFloat = 10.0
}

// MARK:- 颜色方法
func kRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

// MARK:- 常用按钮颜色
// 颜色参考 http://www.sioe.cn/yingyong/yanse-rgb-16/

let kThemeWhiteColor = UIColor.hexColor(0xFFFFFF)
let kThemeWhiteSmokeColor = UIColor.hexColor(0xF5F5F5)
let kThemeMistyRoseColor = UIColor.hexColor(0xFFE4E1)  // 薄雾玫瑰
let kThemeGainsboroColor = UIColor.hexColor(0xF3F4F5)  // 亮灰色
let kThemeOrangeRedColor = UIColor.hexColor(0xFF4500)  // 橙红色
let kThemeLimeGreenColor = UIColor.hexColor(0x32CD32)  // 酸橙绿
let kThemeSnowColor = UIColor.hexColor(0xFFFAFA)
let kThemeLightGreyColor = UIColor.hexColor(0xD3D3D3)
let kThemeGreyColor = UIColor.hexColor(0xA9A9A9)
let kThemeTomatoColor = UIColor.hexColor(0xF7583B)
let kThemeDimGrayColor = UIColor.hexColor(0x696969)
let kThemeBlackColor = UIColor.hexColor(0x000000)
let kThemeBackgroundColor = UIColor.hexColor(0xF4F4F4)


// MARK:- 自定义打印方法
func HCLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):(\(lineNum))-\(message)")
        
    #endif
}

