//
//  NewsService.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import CoreData


final class NewsService {

    let requestManager = RequestManager()
    
    func loadNews(completion: @escaping ([NewsTitleItem], Error?) -> Void) {
        requestManager.request(path: "https://api.tinkoff.ru/v1/news") { (data, error) in
            if let error = error {
                completion([], error)
            }
            if let data = data {
                DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { [weak self] in
                    let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()
                    context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
                    JSONMapper().mapJSONArray(data: data,
                                              key: "payload",
                                              entityClassName: "NewsTitleItem",
                                              context: context)
                    
                    do {
                        try context.save()
                        let fetchedNews = try self?.fetchNews() ?? []
                        completion(fetchedNews, nil)
                    } catch(let error) {
                        completion([], error)
                    }
                }
            }
        }
    }
    
    func fetchNews(completion: @escaping ([NewsTitleItem], Error?) -> Void) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { [weak self] in
            do {
                let fetchedNews = try self?.fetchNews() ?? []
                completion(fetchedNews, nil)
            } catch(let error) {
                completion([], error)
            }
        }
    }
    
    
    fileprivate func fetchNews() throws -> [NewsTitleItem] {
        let fetchRequest: NSFetchRequest<NewsTitleItem> = NewsTitleItem.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "publicationDate", ascending: false)
        ]
        fetchRequest.fetchBatchSize = 30
        
        return try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
    }

}
