//
//  HCPlayUserInfoModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/2/4.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 
 albums : 9
 anchorGrade : 15
 answerCount : 0
 askAndAnswerBrief : ""
 askPrice : "0.00"
 followers : 1542581
 isOpenAskAndAnswer : false
 isVerified : true
 isVip : false
 nickname : "吴晓波频道"
 personDescribe : "解密商业世界各种“真相”"
 personalSignature : "著名财经作家吴晓波，推出国内第一档财经脱口秀。只与最好玩的商业世界有关：细数那些企业家们犯过的错、解析经济发展的大小事件、讲述财经热点..."
 ptitle : "财经作家，吴晓波频道创始人"
 skilledTopic : ""
 smallLogo : "http://fdfs.xmcdn.com/group4/M04/D0/51/wKgDtFP2qljgWGrYAAR86TSbKQg782_mobile_small.jpg"
 tracks : 753
 uid : 12495477
 verifyType : 1
 
 */

struct HCPlayUserInfoModel: Mappable {

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        albums <- map["albums"]
        nickname <- map["nickname"]
        personDescribe <- map["personDescribe"]
        personalSignature <- map["personalSignature"]
        ptitle <- map["ptitle"]
        
        smallLogo <- map["smallLogo"]
        followers <- map["followers"]
    }
    
    var albums = 0
    var nickname = ""
    var personDescribe = ""
    var personalSignature = ""
    var ptitle = ""
    
    var smallLogo = ""
    var followers = 0
}
