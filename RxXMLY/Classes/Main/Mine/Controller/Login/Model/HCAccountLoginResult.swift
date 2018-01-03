//
//  HCAccountLoginResult.swift
//  RxXMLY
//
//  Created by sessionCh on 2018/1/3.
//  Copyright © 2018年 sessionCh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum HCAccountLoginResult {
    case ok(message:String)
    case empty
    case failed(message:String)
}

extension HCAccountLoginResult {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case let .failed(message):
            return message
        }
    }
}

extension HCAccountLoginResult {
    var borderColor: CGColor {
        switch self {
        case .ok:
            return kThemeGainsboroColor.cgColor
        case .empty:
            return kThemeOrangeRedColor.cgColor
        case .failed:
            return kThemeOrangeRedColor.cgColor
        }
    }
}

extension Reactive where Base: UITextField {
    var validationResult: Binder<HCAccountLoginResult> {
        return Binder(self.base) { field, result in
            field.layer.borderColor = result.borderColor
        }
    }
}



