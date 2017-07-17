//
//  String+fromHTML.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 14.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func fromHTML() -> NSAttributedString? {
        if let data = self.data(using: self.fastestEncoding, allowLossyConversion: true) {
            return try? NSAttributedString(data: data,
                                           options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                           documentAttributes: nil)
        }
        return nil
    }
}
