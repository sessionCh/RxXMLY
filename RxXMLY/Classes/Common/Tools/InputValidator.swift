//
//  InputValidator.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/29.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

class InputValidator: NSObject {

    class func isValidEmail(email: String) -> Bool {
        
        let re = try? NSRegularExpression(pattern: "^\\S+@\\S+\\.\\S+$", options: .caseInsensitive)
        
        if let re = re {
            let range = NSMakeRange(0, email.lengthOfBytes(using: String.Encoding.utf8))
            let result = re.matches(in: email, options: .reportProgress, range: range)
            return result.count > 0
        }
        
        return false
    }
    
    class func isValidPassword(password: String) -> Bool {
        return password.characters.count >= 8
    }
}
