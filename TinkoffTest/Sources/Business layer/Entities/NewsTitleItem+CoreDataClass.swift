//
//  NewsTitleItem+CoreDataClass.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation
import CoreData

@objc(NewsTitleItem)
public class NewsTitleItem: NSManagedObject, Mappable {

    func mapping(json: [String: Any]) {
        guard
            let id = json["id"] as? String,
            let publicationDateNumber = (json["publicationDate"] as? [String: Any])?["milliseconds"] as? Double
            else {
                return
        }
        
        self.id = id
        self.text = json["text"] as? String//(json["text"] as? String)?.fromHTML()?.string
        self.publicationDate = Date.fromMilliseconds(publicationDateNumber) as NSDate
    }
    
}
