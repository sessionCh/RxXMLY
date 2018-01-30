//
//  HCTimeTools.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/25.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit

class HCTimeTools: NSObject {

    // MARK:- 秒转换成 00:00:00 格式
    class func formatPlayTime(secounds: TimeInterval) -> String {
        if secounds.isNaN {
            return "00:00"
        }
        var minute = Int(secounds / 60)
        let second = Int(secounds.truncatingRemainder(dividingBy: 60))
        var hour = 0
        if minute >= 60 {
            hour = Int(minute / 60)
            minute = minute - hour * 60
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        return String(format: "%02d:%02d", minute, second)
    }    
}
