
//
//  HCRefreshGifHeader.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/19.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit
import MJRefresh

class HCRefreshGifHeader: MJRefreshGifHeader {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 临时方案，改动最小，不破坏第三方库
        self.stateLabel.isHidden = false
        self.lastUpdatedTimeLabel.isHidden = true
        self.gifView.contentMode = .center
        self.mj_h = 80
        self.gifView.mj_w = self.mj_w
        self.gifView.top = self.top + 80.0
        self.gifView.height = self.mj_h - 60.0
        self.stateLabel.top = self.gifView.bottom
    }
}
