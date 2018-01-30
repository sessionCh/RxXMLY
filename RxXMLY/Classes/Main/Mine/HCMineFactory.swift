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
    class func loadMineModels() -> [[HCSettingCellModel]] {
        
        let model1_1 = HCSettingCellModel(leftIcon: "me_setting_program",
                                          title: "我的作品",
                                          description: nil,
                                          dotIcon: nil,
                                          rightIcon: "meRecord",
                                          isHiddenBottomLine: true,
                                          cellType: .rightRecordButton)
        
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
                                          rightIcon: "cell_arrow")
        let model3_2 = HCSettingCellModel(leftIcon: "me_setting_nightmode",
                                          title: "夜间模式",
                                          description: nil,
                                          dotIcon: nil,
                                          rightIcon: nil,
                                          isHiddenBottomLine: true,
                                          cellType: .rightSwitch(isOn: false))

        let model4_1 = HCSettingCellModel(leftIcon: "me_setting_feedback",
                                          title: "帮助与反馈",
                                          description: nil,
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow")
        let model4_2 = HCSettingCellModel(leftIcon: "me_setting_setting",
                                          title: "设置",
                                          description: nil,
                                          dotIcon: "noread_icon",
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

    // MARK:- 设置
    class func loadSettingModels() -> [[HCSettingCellModel]] {
        
        let model1_1 = HCSettingCellModel(leftIcon: nil,
                                          title: "智能硬件",
                                          description: nil,
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow",
                                          isHiddenBottomLine: true)
        
        
        let model2_1 = HCSettingCellModel(leftIcon: nil,
                                          title: "特色闹铃",
                                          description: nil,
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow")
        let model2_2 = HCSettingCellModel(leftIcon: nil,
                                          title: "定时关闭",
                                          description: nil,
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow",
                                          isHiddenBottomLine: true)
        
        
        let model3_1 = HCSettingCellModel(leftIcon: nil,
                                          title: "推送设置",
                                          description: "别错过重要信息，去开启",
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow")
        let model3_2 = HCSettingCellModel(leftIcon: nil,
                                          title: "收听偏好设置",
                                          description: "",
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow",
                                          isHiddenBottomLine: true)
        
        
        let model4_1 = HCSettingCellModel(leftIcon: nil,
                                          title: "断点续听",
                                          description: "",
                                          dotIcon: nil,
                                          rightIcon: nil,
                                          isHiddenBottomLine: false,
                                          cellType: .rightSwitch(isOn: true))
        let model4_2 = HCSettingCellModel(leftIcon: nil,
                                          title: "2G/3G/4G播放和下载",
                                          description: "",
                                          dotIcon: nil,
                                          rightIcon: nil,
                                          isHiddenBottomLine: false,
                                          cellType: .rightSwitch(isOn: false))
        let model4_3 = HCSettingCellModel(leftIcon: nil,
                                          title: "清理占用空间",
                                          description: "0.0M",
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow",
                                          isHiddenBottomLine: true,
                                          cellType: .rightTextLab)

        
        let model5_1 = HCSettingCellModel(leftIcon: nil,
                                          title: "特色功能",
                                          description: "",
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow")
        let model5_2 = HCSettingCellModel(leftIcon: nil,
                                          title: "新版本介绍",
                                          description: "",
                                          dotIcon: "noread_icon",
                                          rightIcon: "cell_arrow")
        let model5_3 = HCSettingCellModel(leftIcon: nil,
                                          title: "给喜马拉雅好评",
                                          description: "",
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow")
        let model5_4 = HCSettingCellModel(leftIcon: nil,
                                          title: "关于",
                                          description: "",
                                          dotIcon: nil,
                                          rightIcon: "cell_arrow",
                                          isHiddenBottomLine: true)

        
        var models = [[HCSettingCellModel]]()
        
        // 充当 SectionHeader 数据模型
        let placeModel = HCSettingCellModel()
        
        models.append([placeModel, model1_1])
        models.append([placeModel, model2_1, model2_2])
        models.append([placeModel, model3_1, model3_2])
        models.append([placeModel, model4_1, model4_2, model4_3])
        models.append([placeModel, model5_1, model5_2, model5_3, model5_4])

        return models
    }
}
