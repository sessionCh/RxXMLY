
//
//  HCTrackInfoModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/4.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 
 albumId : 9996644
 bulletSwitchType : 2
 categoryId : 8
 categoryName : "商业财经"
 comments : 172
 coverLarge : "http://fdfs.xmcdn.com/group17/M03/D0/07/wKgJJFmUHkKTmXH5AAJ-8Z3LCyo239_mobile_large.jpg"
 coverMiddle : "http://fdfs.xmcdn.com/group17/M03/D0/07/wKgJJFmUHkKTmXH5AAJ-8Z3LCyo239_web_large.jpg"
 coverSmall : "http://fdfs.xmcdn.com/group17/M03/D0/07/wKgJJFmUHkKTmXH5AAJ-8Z3LCyo239_web_meduim.jpg"
 createdAt : 1502889129000
 discountedPrice : 180
 displayDiscountedPrice : "180.00喜点"
 displayPrice : "180.00喜点"
 displayVipPrice : "171.00喜点"
 downloadAacSize : 1224683
 downloadAacUrl : "http://download.xmcdn.com/group17/M04/D1/5D/wKgJKVmUbSbjsUx6ABKv66-_PX4884.m4a"
 downloadSize : 1582049
 downloadUrl : "http://download.xmcdn.com/group26/M04/F9/BA/wKgJWFmURKbi8m1WABgj4QkX9HU465.aac"
 duration : 395
 images
 isAuthorized : false
 isDraft : false
 isFree : true
 isLike : false
 isPaid : true
 isPublic : true
 isRichAudio : false
 isVideo : false
 isVipFree : false
 likes : 500
 playPathAacv164 : "http://audio.xmcdn.com/group18/M0B/CF/E1/wKgJJVmURKSjsNCCADDZfM8XhW4400.m4a"
 playPathAacv224 : "http://audio.xmcdn.com/group17/M04/D1/5D/wKgJKVmUbSbjsUx6ABKv66-_PX4884.m4a"
 playPathHq : ""
 playUrl32 : "http://fdfs.xmcdn.com/group22/M06/F0/FC/wKgJM1mURP6xNY8nABggNBewHCk372.mp3"
 playUrl64 : "http://fdfs.xmcdn.com/group18/M0B/CF/E1/wKgJJVmURKODBl0dADBAH7PA14c520.mp3"
 playtimes : 207172
 price : 180
 priceTypeEnum : 2
 priceTypeId : 2
 priceTypes
 processState : 2
 ret : 0
 sampleDuration : 90
 shortRichIntro : "
 听前思考：
 
 有一个词呢最近很流行，叫做Freestyle，好像是一夜之间嘻哈文化进入到了中国，今天我们就来谈一谈嘻哈文化是怎么产生的，而今天中国为什么它会突然地流行起来？
 
 "
 status : 1
 title : "【免费试听】中国有嘻哈火了，是因为经济不好了？"
 trackId : 47581915
 type : 0
 uid : 12495477
 vipPrice : 171
 
 */

struct HCTrackInfoModel: Mappable {

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        albumId <- map["albumId"]
        shortRichIntro <- map["shortRichIntro"]
        title <- map["title"]
        trackId <- map["trackId"]
        categoryName <- map["categoryName"]
        
        categoryId <- map["categoryId"]
        coverLarge <- map["coverLarge"]
    }
    
    var albumId = 0
    var shortRichIntro = ""
    var title = ""
    var trackId: UInt32 = 0
    var categoryName = ""
    
    var categoryId: UInt32 = 0
    var coverLarge = ""
}
