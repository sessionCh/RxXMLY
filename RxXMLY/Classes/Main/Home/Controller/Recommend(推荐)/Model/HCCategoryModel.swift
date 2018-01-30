//
//  HCCategoryModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

/**
 
 bottomHasMore : false
 categoryId : 3
 direction : "column"
 hasMore : true
 keywords : []
 list : []
 loopCount : 6
 moduleType : "categoriesForShort"
 showInterestCard : false
 target : {}
 title : "最热有声书"
 
 */

import Foundation
import ObjectMapper

struct HCCategoryModel: Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        bottomHasMore <- map["bottomHasMore"]
        categoryId <- map["categoryId"]
        direction <- map["direction"]
        hasMore <- map["hasMore"]
        keywords <- map["keywords"]
        
        list <- map["list"]
        loopCount <- map["loopCount"]
        moduleType <- map["moduleType"]
        showInterestCard <- map["showInterestCard"]
        target <- map["target"]

        title <- map["title"]
    }
    
    var bottomHasMore = false
    var categoryId = 0
    var direction = ""
    var hasMore = true
    var keywords : [HCKeywardsModel]?
    
    var list : [HCRecommendItemModel]?
    var loopCount = 0
    var moduleType = ""
    var showInterestCard = false
    var target : [String : Any]?

    var title = ""
}

