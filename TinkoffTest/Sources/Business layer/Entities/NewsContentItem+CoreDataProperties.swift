//
//  NewsContentItem+CoreDataProperties.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation
import CoreData


extension NewsContentItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsContentItem> {
        return NSFetchRequest<NewsContentItem>(entityName: "NewsContentItem")
    }

    @NSManaged public var content: String?
    @NSManaged public var creationDate: NSDate?
    @NSManaged public var lastModificationDate: NSDate?

}
