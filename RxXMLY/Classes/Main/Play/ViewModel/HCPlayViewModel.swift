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
import RxAlamofire
import SwiftyJSON
import RxDataSources
import ObjectMapper

class HCPlayViewModel: NSObject {

    private let vmDatas = Variable<[(HCPlayModel?, [HCPlayCellModel])]>([])
}

extension HCPlayViewModel: HCViewModelType {
    
    typealias Input = HCPlayInput
    typealias Output = HCPlayOutput
    
    struct HCPlayInput {
        
    }
    
    struct HCPlayOutput {
        
        let sections: Driver<[HCPlaySection]>
        
        let requestCommand = PublishSubject<Bool>()

        init(sections: Driver<[HCPlaySection]>) {
            self.sections = sections
        }
    }
    
    func transform(input: HCPlayViewModel.HCPlayInput) -> HCPlayViewModel.HCPlayOutput {
        
        let temp_sections = vmDatas.asObservable().map({ (sections) -> [HCPlaySection] in
            return sections.map({ (playModel, models) -> HCPlaySection in
                return HCPlaySection(playModel: playModel, items: models)
            })
        }).asDriver(onErrorJustReturn: [])
        
        let output = HCPlayOutput(sections: temp_sections)
        
        output.requestCommand.subscribe(onNext: { [weak self] (_) in
            guard let `self` = self else { return }
            
            let request = json(.get, kUrlGetPlayDetail)
            
            // 获取数据
            request.hc_json({
                
                return JSON($0)
            }).mapObject(HCPlayModel.self).subscribe(onNext: { (datas) in
                
                guard let albumInfo = datas.albumInfo else { return }
                guard let noCacheInfo = datas.noCacheInfo else { return }
                guard let trackInfo = datas.trackInfo else { return }
                guard let userInfo = datas.userInfo else { return }
                
                var playModel = HCPlayModel()
                playModel.albumInfo = albumInfo
                playModel.noCacheInfo = noCacheInfo
                playModel.trackInfo = trackInfo
                playModel.userInfo = userInfo
                
                var sectionArr: [(HCPlayModel?, [HCPlayCellModel])] = []
                
                // 订阅专辑、声音简介 部分
                sectionArr.append((playModel, [HCPlayCellModel(),
                                               HCPlayCellModel(),
                                               HCPlayCellModel()]))
                
                // 推荐专辑 部分
                if let count = playModel.noCacheInfo?.associationAlbumsInfo?.count, count > 0 {
                    sectionArr.append((playModel, [HCPlayCellModel(),
                                                   HCPlayCellModel(),
                                                   HCPlayCellModel(),
                                                   HCPlayCellModel()]))
                }
                // 放入空用来占位
                else {
                    sectionArr.append((playModel, []))
                }
                
                // 主播介绍 部分
                if playModel.userInfo != nil {
                    sectionArr.append((playModel, [HCPlayCellModel(),
                                                   HCPlayCellModel()]))
                }
                
                self.vmDatas.value = sectionArr

            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
        return output
    }
}

struct HCPlaySection {
    
    var playModel: HCPlayModel?
    var items: [Item]
}

extension HCPlaySection: SectionModelType {
    typealias Item = HCPlayCellModel
    
    init(original: HCPlaySection, items: [HCPlayCellModel]) {
        self = original
        self.items = items
    }
}


