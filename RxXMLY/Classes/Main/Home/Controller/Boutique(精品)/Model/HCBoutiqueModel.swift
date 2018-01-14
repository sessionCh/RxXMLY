//
//  HCBoutiqueModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/14.
//  Copyright © 2018年 sessionCh. All rights reserved.
//  首页-精品

import Foundation
import ObjectMapper

/**
 
 ret : 0
 keywords
 categoryContents
 hasRecommendedZones : false
 focusImages
 msg : "成功"
 serverMilliseconds : 1515906325501
 
 */

struct HCBoutiqueModel: Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        ret <- map["ret"]
        hasRecommendedZones <- map["hasRecommendedZones"]
        msg <- map["msg"]
        serverMilliseconds <- map["serverMilliseconds"]
        
        keywordList <- map["keywords.list"]
        categoryList <- map["categoryContents.list"]
        squareList <- map["categoryContents.list.3.list"]
        focusList <- map["focusImages.data"]
    }
    
    var ret = 0
    var hasRecommendedZones = false
    var msg = "成功"    
    var serverMilliseconds: UInt32 = 0
    
    var keywordList: [HCKeywardsModel]?
    var squareList: [HCSquareModel]?
    var focusList: [HCFocusModel]?
    var categoryList: [HCCategoryModel]?
}


