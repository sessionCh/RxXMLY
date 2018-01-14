//
//  HCFocusModel.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

/**
 
 "adId": 41892,
 "adType": 0,
 "buttonShowed": false,
 "clickAction": -1,
 "clickTokens": ["inIEgatIFLVnTqKaWrGVNt/F5qd4/UPMEuxGzAyUFIIMP4I7JKEg9ROkh3k45vQO", "EmH6Tly0XTA6Az9RI4j/0s89FsE333MqFiB8GbST7bYMP4I7JKEg9ROkh3k45vQO", "J42B2rewA3tqvPhwdaoqqtd8xfm/zo69QiIcIIzZuxcMP4I7JKEg9ROkh3k45vQO"],
 "clickType": 1,
 "cover": "http://fdfs.xmcdn.com/group36/M00/62/01/wKgJUlozZ-zACrrjAAIeynG4BQg008.jpg",
 "description": "",
 "displayType": 1,
 "isAd": false,
 "isInternal": 1,
 "isLandScape": false,
 "isShareFlag": false,
 "link": "http://ad.ximalaya.com/adrecord?sdn=H4sIAAAAAAAAAKtWykhNTEktUrLKK83J0VFKzs_PzkyF8QoSixJzU0tSi4qVrKqVElM8S1JzPVOUrJRMDC0sjZRqawGgcac5PwAAAA&ad=41892&xmly=uiwebview",
 "name": "",
 "openlinkType": 0,
 "realLink": "iting://open?msg_type=13&album_id=8225829",
 "showTokens": ["B8W2CTPeKNlhRwRpQQl3+pfGBAKcdSw31R/cMpSQi94MP4I7JKEg9ROkh3k45vQO", "CpGU2xkE7lN+W6My8OT342a677hQtMwkrph+szoSoFwMP4I7JKEg9ROkh3k45vQO", "0KK0zVovY5nS0sd1oiuy4swCRd7bqaHuBodzkD/A238MP4I7JKEg9ROkh3k45vQO", "JhRWTadKClFkY2g9km84p8/X4H97k38TrwlHziQYIxcMP4I7JKEg9ROkh3k45vQO", "nMIShpz4zBEeeq7vFipX4byOMqA7GCUCs9OT4zYi0JkMP4I7JKEg9ROkh3k45vQO"],
 "targetId": -1,
 "thirdClickStatUrls": []
 
 */

import Foundation
import ObjectMapper

struct HCFocusModel: Mappable {
    
    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        
        adId <- map["adId"]
        cover <- map["cover"]
        link <- map["link"]
        realLink <- map["realLink"]
        name <- map["name"]
        
        description <- map["description"]
    }
    
    var adId = 0
    var cover = ""
    var link = ""
    var realLink = ""
    var name = ""
    
    var description = ""
}

