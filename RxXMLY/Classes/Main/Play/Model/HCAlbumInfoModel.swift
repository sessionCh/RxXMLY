//
//  HCAlbumInfoModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/4.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 
 albumId : 9996644
 canInviteListen : true
 canShareAndStealListen : true
 categoryId : 8
 coverLarge : "http://fdfs.xmcdn.com/group19/M03/D0/0D/wKgJK1mUGpDhtaU9AAJ-8Z3LCyo849_mobile_large.jpg"
 coverMiddle : "http://fdfs.xmcdn.com/group19/M03/D0/0D/wKgJK1mUGpDhtaU9AAJ-8Z3LCyo849_mobile_meduim.jpg"
 coverOrigin : "http://fdfs.xmcdn.com/group19/M03/D0/0D/wKgJK1mUGpDhtaU9AAJ-8Z3LCyo849.jpg"
 coverSmall : "http://fdfs.xmcdn.com/group19/M03/D0/0D/wKgJK1mUGpDhtaU9AAJ-8Z3LCyo849_mobile_small.jpg"
 coverWebLarge : "http://fdfs.xmcdn.com/group19/M03/D0/0D/wKgJK1mUGpDhtaU9AAJ-8Z3LCyo849_web_large.jpg"
 createdAt : 1502879298000
 discountedPrice : 180
 displayDiscountedPrice : "180.00喜点"
 displayPrice : "180.00喜点"
 displayVipPrice : "171.00喜点"
 hasNew : true
 intro : "冯仑，柳传志，雷军，梁文道强烈推荐 每天5分钟，听吴晓波唤醒你的商业智慧 世界如此喧嚣，真相何其稀少，你需要《每天听见吴晓波》，每天五分钟的商业日课，吴晓波为你分析当前的经济形势，评说时下的财经热点，告诉你那些使他大受启发的经典书籍。"
 isAlbumOpenGift : false
 isAuthorized : false
 isDraft : false
 isFavorite : false
 isPaid : true
 isVipFree : false
 paidVoiceAlertTemplate
 price : 180
 priceTypeEnum : 2
 priceTypeId : 2
 priceUnit : "喜点"
 refundSupportType : 0
 saleScope : 0
 serializeStatus : 1
 status : 1
 tags : "吴晓波,腾讯传,财经,房地产,互联网,经济,商业,吴晓波频道,每天听见吴晓波,马云,创业"
 title : "每天听见吴晓波·第二季"
 uid : 12495477
 updatedAt : 1517528176000
 vipPrice : 171
 
 */

struct HCAlbumInfoModel: Mappable {

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        albumId <- map["albumId"]
        intro <- map["intro"]
        tags <- map["tags"]
        title <- map["title"]
        coverLarge <- map["coverLarge"]
    }
    
    var albumId: UInt32 = 0
    var intro = ""
    var tags = ""
    var title = ""
    var coverLarge = ""
}
