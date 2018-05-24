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
    
    typealias JSON = [String: Any]

    @discardableResult
    func mapJSONArray<T: NSManagedObject>(data: Data, key: String?, entityClassName: String, context: NSManagedObjectContext) -> [T] {
        let jsonData = data.asJson
        var jsonArray = jsonData as? [JSON]
        if let key = key {
            jsonArray = (jsonData as? JSON)?[key] as? [JSON]
        }
        return jsonArray?.compactMap { element in
            if let description = NSEntityDescription.entity(forEntityName: entityClassName, in: context) {
                if let entity = NSManagedObject(entity: description, insertInto: context) as? Mappable {
                    entity.mapping(json: element)
                    return entity as? T
                }
            }
            return nil
        } ?? []
    }
    
    @discardableResult
    func mapJSONObject<T: NSManagedObject>(data: Data, key: String?, entityClassName: String, context: NSManagedObjectContext) -> T? {
        let jsonData = data.asJson
        var jsonObject = jsonData as? JSON
        if let key = key {
            jsonObject = (jsonData as? JSON)?[key] as? JSON
        }
        if let description = NSEntityDescription.entity(forEntityName: entityClassName, in: context) {
            if let entity = NSManagedObject(entity: description, insertInto: context) as? Mappable {
                if let jsonObject = jsonObject {
                    entity.mapping(json: jsonObject)
                }
                return entity as? T
            }
        }
        return nil
    }

}
