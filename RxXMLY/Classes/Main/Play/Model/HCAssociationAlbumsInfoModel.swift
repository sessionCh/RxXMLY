//
//  HCAssociationAlbumsInfoModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/6.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

/*
 
 albumId : 4633831
 coverMiddle : "http://fdfs.xmcdn.com/group26/M03/24/99/wKgJWFjKkOfhtj-SAAFdYJM1p44447_mobile_small.jpg"
 coverSmall : "http://fdfs.xmcdn.com/group26/M03/24/99/wKgJWFjKkOfhtj-SAAFdYJM1p44447_mobile_small.jpg"
 discountedPrice : 180
 displayDiscountedPrice : "180.00喜点"
 displayPrice : "180.00喜点"
 displayVipPrice : "171.00喜点"
 intro : "此专辑《每天听见吴晓波2016-2017》已经完更"
 isDraft : false
 isPaid : true
 isVipFree : false
 price : 180
 priceTypeEnum : 2
 priceTypeId : 2
 priceUnit : "喜点"
 recSrc : "MAIN"
 recTrack : "ItemG.5"
 refundSupportType : 0
 title : "每天听见吴晓波·第一季"
 uid : 12495477
 updatedAt : 1517463574000
 vipPrice : 171
 
 */

import Foundation
import ObjectMapper

struct HCAssociationAlbumsInfoModel: Mappable {

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        albumId <- map["albumId"]
        coverMiddle <- map["coverMiddle"]
        displayDiscountedPrice <- map["displayDiscountedPrice"]
        intro <- map["intro"]
        title <- map["title"]
        
        updatedAt <- map["updatedAt"]
        discountedPrice <- map["discountedPrice"]
        uid <- map["uid"]
        isVipFree <- map["isVipFree"]
        isPaid <- map["isPaid"]
    }
    
    var albumId: UInt32 = 0
    var coverMiddle = ""
    var displayDiscountedPrice = ""
    var intro = ""
    var title = ""
    
    var updatedAt: UInt32 = 0
    var discountedPrice: CGFloat = 0
    var uid: UInt32 = 0
    var isVipFree: Bool = false
    var isPaid: Bool = false
}
