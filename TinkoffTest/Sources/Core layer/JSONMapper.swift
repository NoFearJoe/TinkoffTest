//
//  JSONMapper.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation
import CoreData


protocol Mappable {
    func mapping(json: [String: Any])
}


final class JSONMapper {

    @discardableResult
    func mapJSONArray<T: NSManagedObject>(data: Data, key: String?, entityClassName: String, context: NSManagedObjectContext) -> [T] {
        if let json = data.asJson as? [String: Any] {
            if let key = key {
                if let jsonArray = json[key] as? [[String: Any]] {
                    return jsonArray.flatMap { element in
                        if let description = NSEntityDescription.entity(forEntityName: entityClassName, in: context) {
                            if let entity = NSManagedObject(entity: description, insertInto: context) as? Mappable {
                                entity.mapping(json: element)
                                return entity as? T
                            }
                        }
                        return nil
                    }
                }
            }
        }
        return []
    }

}
