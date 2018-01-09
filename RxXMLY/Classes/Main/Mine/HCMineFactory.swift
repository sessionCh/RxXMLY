//
//  HCMineFactory.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/8.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit

class HCMineFactory: NSObject {

}

// MARK:- 外部访问方法
extension HCMineFactory {
    
    // MARK:- 我的
    class func loadSettingModels() -> [[HCSettingCellModel]] {
        
        let model1_1 = HCSettingCellModel(leftIcon: "me_setting_program",
                                          title: "我的作品",
                                          description: nil,
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow",
                                          isHiddenBottomLine: true)
        
        let model2_1 = HCSettingCellModel(leftIcon: "me_setting_plus",
                                          title: "巅峰会员",
                                          description: nil,
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow")
        let model2_2 = HCSettingCellModel(leftIcon: "me_setting_CPS",
                                          title: "分享赚钱",
                                          description: nil,
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow",
                                          isHiddenBottomLine: true)
        
        let model3_1 = HCSettingCellModel(leftIcon: "scan_scan",
                                          title: "扫一扫",
                                          description: nil,
                                          dotIcon: nil,
                                          rightIcon: "meRecord")
        let model3_2 = HCSettingCellModel(leftIcon: "me_setting_nightmode",
                                          title: "夜间模式",
                                          description: nil,
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow",
                                          isHiddenBottomLine: true)

        let model4_1 = HCSettingCellModel(leftIcon: "me_setting_feedback",
                                          title: "帮助与反馈",
                                          description: nil,
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow")
        let model4_2 = HCSettingCellModel(leftIcon: "me_setting_setting",
                                          title: "设置",
                                          description: nil,
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow",
                                          isHiddenBottomLine: true)
        
        var models = [[HCSettingCellModel]]()
        
         // 充当 SectionHeader 数据模型
        let placeModel = HCSettingCellModel()

        models.append([placeModel, model1_1])
        models.append([placeModel, model2_1, model2_2])
        models.append([placeModel, model3_1, model3_2])
        models.append([placeModel, model4_1, model4_2])

        return models
    }
}
