//
//  Data+JSON.swift
//
//  Created by Ilya Kharabet on 25.11.16.
//  Copyright © 2016 IK. All rights reserved.
//

import Foundation

extension Data {
    
    static func from(json object: Any) -> Data? {
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
