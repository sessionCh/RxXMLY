//
//  HCPlayModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/4.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 
 ret : 0
 albumInfo
 associationAlbumsInfo
 noCacheInfo
 trackInfo
 userInfo
 msg : "0"
 
 */

struct HCPlayModel: Mappable {

    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        ret <- map["ret"]
        albumInfo <- map["albumInfo"]
        noCacheInfo <- map["noCacheInfo"]
        trackInfo <- map["trackInfo"]
        userInfo <- map["userInfo"]
        
        msg <- map["msg"]
    }
    
    var ret = 0
    var albumInfo: HCAlbumInfoModel?
    var noCacheInfo: HCNoCacheInfoModel?
    var trackInfo: HCTrackInfoModel?
    var userInfo: HCPlayUserInfoModel?
    
    var msg = ""
}
