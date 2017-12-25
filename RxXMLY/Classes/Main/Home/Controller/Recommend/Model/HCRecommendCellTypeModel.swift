//
//  HCRecommendCellTypeModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/18.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

enum HCRecommendCellType {
    case none
    case defaultSingleCell
    case liveSingleCell
    case defaultThreeCell
}

class HCRecommendCellTypeModel: NSObject {

    var type: HCRecommendCellType = .none
    var section: Int = -1

    override init() {
        super.init()
    }
    
    init(type: HCRecommendCellType, section: Int) {
        super.init()
        self.type = type
        self.section = section
    }
}
