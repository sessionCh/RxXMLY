//
//  HCMineViewModel.swift
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

class HCMineViewModel: NSObject {

    private let vmDatas = Variable<[[HCSettingCellModel]]>([])
}

extension HCMineViewModel: HCViewModelType {
    
    typealias Input = HCMineInput
    typealias Output = HCMineOutput
    
    struct HCMineInput {
        
    }
    
    struct HCMineOutput {
        
        let sections: Driver<[HCMineSection]>
        
        init(sections: Driver<[HCMineSection]>) {
            self.sections = sections
        }
    }
    
    func transform(input: HCMineViewModel.HCMineInput) -> HCMineViewModel.HCMineOutput {
        
        let temp_sections = vmDatas.asObservable().map({ (sections) -> [HCMineSection] in
            return sections.map({ (models) -> HCMineSection in
                return HCMineSection(items: models)
            })
        }).asDriver(onErrorJustReturn: [])

        let output = HCMineOutput(sections: temp_sections)
        
        self.vmDatas.value = HCMineFactory.loadSettingModels()

        return output
    }
}

struct HCMineSection {
    
    var items: [Item]
}

extension HCMineSection: SectionModelType {
    typealias Item = HCSettingCellModel
    
    init(original: HCMineSection, items: [HCSettingCellModel]) {
        self = original
        self.items = items
    }
}


