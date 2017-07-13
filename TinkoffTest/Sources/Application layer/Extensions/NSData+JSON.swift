//
//  NSData+JSON.swift
//  Kinoplan Cinema
//
//  Created by Igor Lemeshev on 12.10.16.
//  Copyright © 2016 TK. All rights reserved.
//

import Foundation

extension Data {
    
    static func from(json object: AnyObject) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
        } catch {
            return nil
        }
    }
    
    var asJson: Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .allowFragments)
        } catch {
            return nil
        }
    }
    
}
