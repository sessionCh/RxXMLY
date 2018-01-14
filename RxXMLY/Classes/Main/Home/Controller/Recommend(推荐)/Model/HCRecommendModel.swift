//
//  HCRecommendModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/17.
//  Copyright © 2017年 sessionCh. All rights reserved.
//  首页-推荐

/**
 
 ret : 0
 maxPageId : 5
 totalCount : 100
 list
 msg : "成功"
 
 */

import Foundation
import ObjectMapper

struct HCRecommendModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        ret <- map["ret"]
        maxPageId <- map["maxPageId"]
        totalCount <- map["totalCount"]
        msg <- map["msg"]

        focusList <- map["list.0.list.0.data"]
        squareList <- map["list.1.list"]
        categoryList <- map["list"]
        nextCategoryList <- map["list"]
    }
    
    var ret = 0
    var maxPageId = 5
    var totalCount = 100
    var msg = "成功"

    var focusList: [HCFocusModel]?
    var squareList: [HCSquareModel]?
    var categoryList: [HCCategoryModel]?
    var nextCategoryList: [HCRecommendItemModel]?
}



