//
//  HCSquareModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

/**
 
 bubbleText : ""
 contentType : "html5"
 contentUpdatedAt : 0
 coverPath : "http://fdfs.xmcdn.com/group34/M0A/54/B6/wKgJYVnypRfjrrvpAAA9l0GXd1w940.jpg"
 enableShare : false
 id : 1907
 isExternalUrl : false
 sharePic : ""
 subtitle : "来自耶鲁、清华、北大、南大、长江商学院的严选好课"
 title :
 url : "http://m.ximalaya.com/master-class/home.html?ts=1513415847580"
 
 */


import Foundation
import ObjectMapper

struct HCSquareModel: Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["adId"]
        coverPath <- map["coverPath"]
        sharePic <- map["sharePic"]
        subtitle <- map["subtitle"]
        title <- map["title"]
        
        url <- map["url"]
    }
    
    var id = 0
    var coverPath = ""
    var sharePic = ""
    var subtitle = ""
    var title = ""
    
    var url = ""
}


