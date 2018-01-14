//
//  HCActivityModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/17.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

/**
 
 shareData : null
 isShareFlag : false
 thirdStatUrl : null
 thirdShowStatUrls : null
 thirdClickStatUrls
 showTokens
 clickTokens
 recSrc : null
 recTrack : null
 link : "http://ad.ximalaya.com/adrecord?sdn=H4sIAAAAAAAAAKtWykhNTEktUrLKK83J0VFKzs_PzkyF8QoSixJzU0tSi4qVrKqVElM8S1JzPVOUrJRMDC2MTJRqawFtHxxrPwAAAA&ad=41824&xmly=uiwebview"
 realLink : "http://m.ximalaya.com/s-activity/a_tcdh/index.html"
 adMark : "http://fdfs.xmcdn.com/group22/M0B/EF/D7/wKgJM1ltap7BdV9dAAAF3O2tHpE659.png"
 isLandScape : false
 isInternal : -1
 cover : "http://fdfs.xmcdn.com/group36/M01/FA/C4/wKgJUloqThKzE1oLAAJQ1xgg26s045.png"
 showstyle : 13
 name : null
 description : null
 scheme : null
 linkType : 1
 displayType : 1
 clickType : 1
 openlinkType : 0
 loadingShowTime : 3000
 apkUrl : null
 adtype : 0
 auto : false
 startAt : 1513511400000
 endAt : 1513590659000
 closable : false
 adid : 41824
 
 */
import Foundation
import ObjectMapper

struct HCActivityModel: Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        adid <- map["adid"]
        link <- map["link"]
        realLink <- map["realLink"]
        adMark <- map["adMark"]
        cover <- map["cover"]
    }
    
    var adid = 0
    var link = ""
    var realLink = ""
    var adMark = ""
    var cover = ""
}


