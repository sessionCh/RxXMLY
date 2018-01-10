//
//  HCSettingViewModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/8.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources

public enum HCSettingViewModelType {
    case none                             // 未知
    case mine                             // 我的
    case setting                          // 设置
}

class HCSettingViewModel: NSObject {

    private let vmDatas = Variable<[[HCSettingCellModel]]>([])
}

extension HCSettingViewModel: HCViewModelType {
    
    typealias Input = HCSettingInput
    typealias Output = HCSettingOutput
    
    struct HCSettingInput {
        
        let type: HCSettingViewModelType
        
        init(type: HCSettingViewModelType) {
            self.type = type
        }
    }
    
    struct HCSettingOutput {
        
        let sections: Driver<[HCSettingSection]>
        
        init(sections: Driver<[HCSettingSection]>) {
            self.sections = sections
        }
    }
    
    func transform(input: HCSettingViewModel.HCSettingInput) -> HCSettingViewModel.HCSettingOutput {
        
        let temp_sections = vmDatas.asObservable().map({ (sections) -> [HCSettingSection] in
            return sections.map({ (models) -> HCSettingSection in
                return HCSettingSection(items: models)
            })
        }).asDriver(onErrorJustReturn: [])

        let output = HCSettingOutput(sections: temp_sections)
        
        let sectionArr: [[HCSettingCellModel]]
        
        switch input.type {
        case .none:
            sectionArr = []
            break
        case .setting:
            sectionArr = HCMineFactory.loadSettingModels()
            break
        case .mine:
            sectionArr = HCMineFactory.loadMineModels()
            break
        }
        self.vmDatas.value = sectionArr

        return output
    }
}

struct HCSettingSection {
    
    var items: [Item]
}

extension HCSettingSection: SectionModelType {
    typealias Item = HCSettingCellModel
    
    init(original: HCSettingSection, items: [HCSettingCellModel]) {
        self = original
        self.items = items
    }
}


