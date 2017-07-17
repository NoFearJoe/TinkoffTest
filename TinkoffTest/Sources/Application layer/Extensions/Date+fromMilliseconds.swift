//
//  Date+fromMilliseconds.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import struct Foundation.Date


extension Date {

    static func fromMilliseconds(_ milliseconds: Double) -> Date {
        return Date(timeIntervalSince1970: milliseconds)
    }

}
