//
//  HCPlayViewModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/2.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources

class HCPlayViewModel: NSObject {

    private let vmDatas = Variable<[[HCPlayCellModel]]>([])
}

extension HCPlayViewModel: HCViewModelType {
    
    typealias Input = HCPlayInput
    typealias Output = HCPlayOutput
    
    struct HCPlayInput {
        
    }
    
    struct HCPlayOutput {
        
        let sections: Driver<[HCPlaySection]>
        
        init(sections: Driver<[HCPlaySection]>) {
            self.sections = sections
        }
    }
    
    func transform(input: HCPlayViewModel.HCPlayInput) -> HCPlayViewModel.HCPlayOutput {
        
        let temp_sections = vmDatas.asObservable().map({ (sections) -> [HCPlaySection] in
            return sections.map({ (models) -> HCPlaySection in
                return HCPlaySection(items: models)
            })
        }).asDriver(onErrorJustReturn: [])
        
        let output = HCPlayOutput(sections: temp_sections)
        
        let sectionArr  = [[HCPlayCellModel(),
                            HCPlayCellModel(),
                            HCPlayCellModel()]]
    
        self.vmDatas.value = sectionArr
        
        return output
    }
}

struct HCPlaySection {
    
    var items: [Item]
}

extension HCPlaySection: SectionModelType {
    typealias Item = HCPlayCellModel
    
    init(original: HCPlaySection, items: [HCPlayCellModel]) {
        self = original
        self.items = items
    }
}


