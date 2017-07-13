//
//  NewsTitleItem+CoreDataProperties.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation
import CoreData


extension NewsTitleItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsTitleItem> {
        return NSFetchRequest<NewsTitleItem>(entityName: "NewsTitleItem")
    }

    @NSManaged public var id: String?
    @NSManaged public var text: String?
    @NSManaged public var publicationDate: NSDate?

}
