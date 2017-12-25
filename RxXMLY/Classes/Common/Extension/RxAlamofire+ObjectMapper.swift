//
//  RxAlamofire+ObjectMapper.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import RxCocoa
import ObjectMapper
import SwiftyJSON

extension ObservableType where E == Any {
    public func hc_json(_ json : @escaping ((E) -> JSON)) -> Observable<Any> {
        return flatMap { (result) -> Observable<Any> in
            return Observable.just(json(result).object)
        }
    }
    
    // 将Json解析为Observable<Model>
    public func mapObject<T: BaseMappable>(_ type: T.Type) -> Observable<T> {
        return flatMap { json -> Observable<T> in
            guard let object = Mapper<T>().map(JSONObject: json) else {
                HCLog("ObjectMapper can't mapping Object")
                return Observable.error(NSError(domain: "HC", code: -1, userInfo: [NSLocalizedDescriptionKey : "ObjectMapper can't mapping Object"]))
            }
            return Observable.just(object)
        }
    }
    // 将Json解析为 Observable<[Model]>
    public func mapArray<T: BaseMappable>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { (json) -> Observable<[T]> in
            guard let objectArr = Mapper<T>().mapArray(JSONObject: json) else {
                HCLog("ObjectMapper can't mapping Array")
                return Observable.error(NSError(domain: "HC", code: -1, userInfo: [NSLocalizedDescriptionKey : "ObjectMapper can't mapping objArray"]))
            }
            return Observable.just(objectArr)
        }
    }
}


