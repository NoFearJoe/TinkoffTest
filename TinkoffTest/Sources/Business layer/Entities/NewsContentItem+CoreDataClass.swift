//
//  NewsContentItem+CoreDataClass.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation
import CoreData

@objc(NewsContentItem)
public class NewsContentItem: NSManagedObject, Mappable {

    func mapping(json: [String: Any]) {
        guard
//            let titleItemDictionary = json["title"] as? [String: Any],
//            let titleItem = NewsTitleItem(json: titleItemDictionary),
            let creationDateNumber = (json["creationDate"] as? [String: Any])?["milliseconds"] as? Double,
            let lastModificationDateNumber = (json["lastModificationDate"] as? [String: Any])?["milliseconds"] as? Double
        else {
            return
        }
        
//        self.titleItem = titleItem
        self.content = json["content"] as? String
        self.creationDate = Date.fromMilliseconds(creationDateNumber) as NSDate
        self.lastModificationDate = Date.fromMilliseconds(lastModificationDateNumber) as NSDate
    }
    
}
