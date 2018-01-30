//
//  HCRecommendItemModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//  首页-通用 数据模型

/**
 
 albumId : 6737591
 categoryId : 6
 commentScore : 4.9
 commentsCount : 183
 discountedPrice : 49
 displayDiscountedPrice : "49.00喜点"
 displayPrice : "49.00喜点"
 infoType : "play_or_score"
 isDraft : false
 isFinished : 2
 isPaid : true
 isVipFree : false
 lastUptrackAt : 1487130859000
 materialType : "album"
 pic : "http://fdfs.xmcdn.com/group23/M07/89/72/wKgJNFijyQfAIZjBAACd_-M6pms486_mobile_large.jpg"
 playsCount : 2589482
 price : 49
 priceTypeEnum : 2
 priceUnit : "喜点"
 recSrc : "TCPB.164V1"
 recTrack : "PayBestB.1001"
 refundSupportType : 0
 subtitle : "凯叔改编：逗趣又内涵，西游记就该这么玩"
 title : "凯叔西游记【第四部全集】"
 tracksCount : 24
 
 // 精品单听
 coverPath : "http://fdfs.xmcdn.com/group36/M07/1B/D7/wKgJUlox4bjxn6MdAACTn0-Xj3E231_mobile_small.jpg"
 footnote : "6首声音"
 
 // 直播
 coverLarge : "http://fdfs.xmcdn.com/group36/M00/90/20/wKgJUlo0jGzRkzMnAAEbPHYKcDQ5206455_mobile_large"
 name : "歪，敌方还有五秒钟到达战场~"
 nickname : "珍视_MC白院长"
 
 // 首页-精品
 intro : "国家级精品国学课，还原真实的孔子"
 tracks : 49
 playsCounts : 5096977
 coverMiddle : "http://fdfs.xmcdn.com/group37/M09/67/6E/wKgJoFpK-86wD11tAAHQ2lluDAE309_mobile_meduim.jpg"
 tags : "国学,论语,孔子"
 trackId : 66732255
 trackTitle : "008|中国人在其他场合是怎么巧用《论语》的？"
 displayVipPrice : "189.05喜点"
 
 */

import Foundation
import ObjectMapper

struct HCRecommendItemModel: Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        albumId <- map["albumId"]
        categoryId <- map["categoryId"]
        commentScore <- map["commentScore"]
        commentsCount <- map["commentsCount"]
        discountedPrice <- map["discountedPrice"]
        
        displayDiscountedPrice <- map["displayDiscountedPrice"]
        displayPrice <- map["displayPrice"]
        materialType <- map["materialType"]
        pic <- map["pic"]
        playsCount <- map["playsCount"]
        
        price <- map["price"]
        priceTypeEnum <- map["priceTypeEnum"]
        priceUnit <- map["priceUnit"]
        recSrc <- map["recSrc"]
        recTrack <- map["recTrack"]
        
        subtitle <- map["subtitle"]
        title <- map["title"]
        tracksCount <- map["tracksCount"]
        isFinished <- map["isFinished"]
        coverPath <- map["coverPath"]
        
        footnote <- map["footnote"]
        coverLarge <- map["coverLarge"]
        name <- map["name"]
        nickname <- map["nickname"]
        intro <- map["intro"]
        
        tracks <- map["tracks"]
        playsCounts <- map["playsCounts"]
        coverMiddle <- map["coverMiddle"]
        tags <- map["tags"]
        trackId <- map["trackId"]
        
        trackTitle <- map["trackTitle"]
        displayVipPrice <- map["displayVipPrice"]
    }
    
    var albumId = 0
    var categoryId = 0
    var commentScore = 0
    var commentsCount = 0
    var discountedPrice = 0
    
    var displayDiscountedPrice = ""
    var displayPrice = ""
    var materialType = ""
    var pic = ""
    var playsCount = 0
    
    var price = 0
    var priceTypeEnum = 0
    var priceUnit = ""
    var recSrc = ""
    var recTrack = ""
    
    var subtitle = ""
    var title = ""
    var tracksCount = 0
    var isFinished = 0
    var coverPath = ""
    
    var footnote = ""
    var coverLarge = ""
    var name = ""
    var nickname = ""
    var intro = ""
    
    var tracks = 0
    var playsCounts = 0
    var coverMiddle = ""
    var tags = ""
    var trackId = 0
    
    var trackTitle = ""
    var displayVipPrice = ""
}
