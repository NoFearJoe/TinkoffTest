//
//  NewsItemService.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation
import CoreData


final class NewsItemService {
    
    let requestManager = RequestManager()
    
    func obtainNewsContent(newsTitleID id: String, completion: @escaping (NewsContentItem?, Error?) -> Void) {
        requestManager.request(path: "https://api.tinkoff.ru/v1/news_content", parameters: ["id": id]) { (data, error) in
            if let error = error {
                completion(nil, error)
            }
            if let data = data {
                DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { [weak self] in
                    let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()
                    let content: NewsContentItem? = JSONMapper().mapJSONObject(data: data,
                                                                               key: "payload",
                                                                               entityClassName: "NewsContentItem",
                                                                               context: context)
                    
                    do {
                        content?.titleItem = try self?.fetchNewsTitle(id: id, context: context)
                        
                        try context.save()
                        
                        let newsContent = try self?.fetchNewsContent(id: id)
                        completion(newsContent, nil)
                    } catch(let error) {
                        completion(nil, error)
                    }
                }
            }
        }
    }
    
    func fetchNewsContent(id: String, completion: @escaping (NewsContentItem?, Error?) -> Void) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { [weak self] in
            do {
                let newsContent = try self?.fetchNewsContent(id: id)
                completion(newsContent, nil)
            } catch(let error) {
                completion(nil, error)
            }
        }
    }
    
    fileprivate func fetchNewsTitle(id: String, context: NSManagedObjectContext) throws -> NewsTitleItem? {
        let fetchRequest: NSFetchRequest<NewsTitleItem> = NewsTitleItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        return try context.fetch(fetchRequest).first
    }
    
    fileprivate func fetchNewsContent(id: String) throws -> NewsContentItem? {
        let fetchRequest: NSFetchRequest<NewsContentItem> = NewsContentItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "titleItem.id = %@", id)
        
        return try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest).first
    }
    
}
