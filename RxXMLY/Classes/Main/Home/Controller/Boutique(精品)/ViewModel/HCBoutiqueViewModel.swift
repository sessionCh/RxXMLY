//
//  HCBoutiqueViewModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx
import RxAlamofire
import SwiftyJSON
import RxDataSources
import ObjectMapper

class HCBoutiqueViewModel: NSObject {

    private let vmDatas = Variable<[([HCKeywardsModel]?, [HCFocusModel]?, [HCSquareModel]?, HCCategoryModel?, [HCRecommendItemModel])]>([])
    
    private var page: Int = 1
}


extension HCBoutiqueViewModel: HCViewModelType {
    
    typealias Input = HCBoutiqueInput
    typealias Output = HCBoutiqueOutput
    
    struct HCBoutiqueInput {
        
    }
    
    struct HCBoutiqueOutput: OutputRefreshProtocol {
        
        var refreshStatus: Variable<HCRefreshStatus>
        
        let sections: Driver<[HCBoutiqueSection]>
        let requestCommand = PublishSubject<Bool>()
        
        init(sections: Driver<[HCBoutiqueSection]>) {
            self.sections = sections
            refreshStatus = Variable<HCRefreshStatus>(.none)
        }
    }
    
    func transform(input: HCBoutiqueViewModel.HCBoutiqueInput) -> HCBoutiqueViewModel.HCBoutiqueOutput {
     
        let temp_sections = vmDatas.asObservable().map({ (sections) -> [HCBoutiqueSection] in
            return sections.map({ (keywordList, focusList, squareList, category, models) -> HCBoutiqueSection in
                return HCBoutiqueSection(keywordList: keywordList, focusList: focusList, squareList: squareList, category: category, items: models)
            })
        }).asDriver(onErrorJustReturn: [])
        
        let output = HCBoutiqueOutput(sections: temp_sections)
        
        output.requestCommand.subscribe(onNext: { [weak self] (isPull) in
            guard let `self` = self else { return }
            
            var url: String = kUrlGetBoutiqueList
            
            if isPull {
                url = kUrlGetBoutiqueList
            } else {
            }
            
            let request = json(.get, url)
            
            // 监听网络
            request.asObservable().subscribe({ (event) in
                switch event {
                case let .error(error):
                    HCLog(error)
                case .next, .completed:
                    self.page = self.page + 1
                    break
                }
                output.refreshStatus.value = .endHeaderRefresh
                output.refreshStatus.value = .endFooterRefresh

            }).disposed(by: self.rx.disposeBag)
            
            // 获取数据
            request.hc_json({
                
                return JSON($0)
            }).mapObject(HCBoutiqueModel.self).subscribe(onNext: { (datas) in
                
                guard let keywordList = datas.keywordList else { return }
                guard let focusList = datas.focusList else { return }
                guard let squareList = datas.squareList else { return }
                guard let categoryList = datas.categoryList else { return }
                
                var temp_category: [HCCategoryModel] = []
                var temp_categorySubList: [[HCRecommendItemModel]] = []

                // 组装数据
                for (index, category) in categoryList.enumerated() {
                    
                    guard index >= 4 else { // 过滤
                        continue
                    }
                    
                    guard let categorySubList = category.list, categorySubList.count > 0 else {
                        continue
                    }
                    // 处理数据
                    temp_category.append(category)
                    temp_categorySubList.append(categorySubList)
                }
            
                var sectionArr: [([HCKeywardsModel]?, [HCFocusModel]?, [HCSquareModel]?, HCCategoryModel?, [HCRecommendItemModel])] = []

                for (index, _) in temp_category.enumerated() {
                    
                    sectionArr.append((keywordList, focusList, squareList, temp_category[index], temp_categorySubList[index]))
                }
                
                // 更新数据
                self.vmDatas.value = sectionArr
                
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
        return output
    }
}

struct HCBoutiqueSection {
   
    var keywordList: [HCKeywardsModel]?
    var focusList: [HCFocusModel]?
    var squareList: [HCSquareModel]?
    var category: HCCategoryModel?

    var items: [Item]
}

extension HCBoutiqueSection: SectionModelType {
    typealias Item = HCRecommendItemModel
 
    init(original: HCBoutiqueSection, items: [HCRecommendItemModel]) {
        self = original
        self.items = items
    }
}

