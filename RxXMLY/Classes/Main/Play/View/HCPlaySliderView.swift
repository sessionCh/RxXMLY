//
//  HCPlaySliderView.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/24.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit

class HCPlaySliderView: UIView {

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        // 获取手指
        let touch = (touches as NSSet).anyObject() as! UITouch
        let nowLocation = touch.location(in: self)
        let preLocation = touch.previousLocation(in: self)
        
        // 获取两个手指的偏移量
        let offsetX = nowLocation.x - preLocation.x
//        let offsetY = nowLocation.y - preLocation.y
        
        var center = self.center
        center.x += offsetX
//        center.y += offsetY
        
        self.center = center
    }
}
