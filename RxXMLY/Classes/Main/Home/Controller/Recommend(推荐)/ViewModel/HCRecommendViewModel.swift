//
//  HCRecommendViewModel.swift
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

class HCRecommendViewModel: NSObject {

    private let vmDatas = Variable<[([HCFocusModel]?, [HCSquareModel]?, HCCategoryModel?, [HCRecommendItemModel]?, [HCRecommendItemModel])]>([])
    
    private var page: Int = 1
}


extension HCRecommendViewModel: HCViewModelType {
    
    typealias Input = HCRecommendInput
    typealias Output = HCRecommendOutput
    
    struct HCRecommendInput {
        
    }
    
    struct HCRecommendOutput: OutputRefreshProtocol {
        
        var refreshStatus: Variable<HCRefreshStatus>
        
        let sections: Driver<[HCRecommendSection]>
        let requestCommand = PublishSubject<Bool>()
        
        init(sections: Driver<[HCRecommendSection]>) {
            self.sections = sections
            refreshStatus = Variable<HCRefreshStatus>(.none)
        }
    }
    
    func transform(input: HCRecommendViewModel.HCRecommendInput) -> HCRecommendViewModel.HCRecommendOutput {
     
        let temp_sections = vmDatas.asObservable().map({ (sections) -> [HCRecommendSection] in
            return sections.map({ (focusList, squareList, category, nextCategoryList, models) -> HCRecommendSection in
                return HCRecommendSection(focusList: focusList, squareList: squareList, category: category, nextCategoryList: nextCategoryList, items: models)
            })
        }).asDriver(onErrorJustReturn: [])
        
        let output = HCRecommendOutput(sections: temp_sections)
        
        output.requestCommand.subscribe(onNext: { [weak self] (isPull) in
            guard let `self` = self else { return }
            
            var url: String = kUrlGetRecommendList
            
            if isPull {
                url = kUrlGetRecommendList
            } else {
                let params = "&pageId=\(self.page)&pageSize=20&scale=2&uid=0&version=6.3.45&xt=1513670067079"
                url = kUrlGetRecommendPullList + params
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
            }).mapObject(HCRecommendModel.self).subscribe(onNext: { (datas) in
                
                guard let focusList = datas.focusList else { return }
                guard let squareList = datas.squareList else { return }
                guard let categoryList = datas.categoryList else { return }
                
                var temp_category: [HCCategoryModel] = []
                var temp_categorySubList: [[HCRecommendItemModel]] = []

                // 组装数据
                for (index, category) in categoryList.enumerated() {
                    
                    guard index >= 2 else { // 前两个分别是
                        continue
                    }
                    
                    guard let categorySubList = category.list, categorySubList.count > 0 else {
                        continue
                    }
                    
                    // 猜你喜欢 精品 三列显示
                    temp_category.append(category)
                    temp_categorySubList.append(categorySubList)
                }
                
                let nextCategoryList = datas.nextCategoryList

                if (nextCategoryList != nil && datas.maxPageId > 0) {
//                    let category = HCCategoryModel(map: Map(mappingType: MappingType.fromJSON, JSON: ["title": "为你推荐"]))
//                    temp_category.append(category!)
//                    temp_categorySubList.append(nextCategoryList!)
                }

                var sectionArr: [([HCFocusModel]?, [HCSquareModel]?, HCCategoryModel?,  [HCRecommendItemModel]?, [HCRecommendItemModel])] = []

                for (index, _) in temp_category.enumerated() {
                    
                    sectionArr.append((focusList, squareList, temp_category[index], nextCategoryList, temp_categorySubList[index]))
                }
                
                // 更新数据
                self.vmDatas.value = sectionArr
                
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
        return output
    }
}

struct HCRecommendSection {
    
    var focusList: [HCFocusModel]?
    var squareList: [HCSquareModel]?
    var category: HCCategoryModel?
    
    var nextCategoryList: [HCRecommendItemModel]?

    var items: [Item]
}

extension HCRecommendSection: SectionModelType {
    typealias Item = HCRecommendItemModel
 
    init(original: HCRecommendSection, items: [HCRecommendItemModel]) {
        self = original
        self.items = items
    }
}

