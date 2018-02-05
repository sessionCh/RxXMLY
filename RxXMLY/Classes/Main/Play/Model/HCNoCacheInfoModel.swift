//
//  HCNoCacheInfoModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/4.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 
 countInfo
 associationAlbumsInfo
 groupInfo
 otherInfo
 recAlbumsPanelTitle : "购买过本专辑的人也喜欢"
 authorizeInfo
 commentInfo
 giftTopUsersInfo
 
 */

struct HCNoCacheInfoModel: Mappable {

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        recAlbumsPanelTitle <- map["recAlbumsPanelTitle"]
        countInfo <- map["countInfo"]
        associationAlbumsInfo <- map["associationAlbumsInfo"]
    }
    
    var recAlbumsPanelTitle = ""
    var countInfo: [String: Any]?
    var associationAlbumsInfo: [HCAssociationAlbumsInfoModel]?
}
