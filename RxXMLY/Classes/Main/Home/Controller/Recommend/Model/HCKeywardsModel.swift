//
//  HCKeywardsModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

/**
 
 categoryId : 3
 categoryTitle : "有声书"
 keywordId : 28
 keywordName : "推理"
 keywordType : 1
 materialType : "keyword"
 realCategoryId : 3
 
 */

import Foundation
import ObjectMapper

struct HCKeywardsModel: Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        categoryId <- map["categoryId"]
        categoryTitle <- map["categoryTitle"]
        keywordId <- map["keywordId"]
        keywordName <- map["keywordName"]
        keywordType <- map["keywordType"]
        
        materialType <- map["materialType"]
        realCategoryId <- map["realCategoryId"]
    }
    
    var categoryId = 0
    var categoryTitle = ""
    var keywordId = 0
    var keywordName = ""
    var keywordType = 0
    
    var materialType = ""
    var realCategoryId = 0
}


