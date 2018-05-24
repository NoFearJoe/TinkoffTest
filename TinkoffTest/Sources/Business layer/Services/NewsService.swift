//
//  NewsService.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import CoreData


protocol NewsServiceProtocol: class {
    func loadNews(completion: @escaping ([NewsTitleItem], Error?) -> Void)
    func fetchNews(completion: @escaping ([NewsTitleItem], Error?) -> Void)
}


final class NewsService: NewsServiceProtocol {

    let requestManager = RequestManager()
    
    func loadNews(completion: @escaping ([NewsTitleItem], Error?) -> Void) {
        requestManager.request(path: "https://api.tinkoff.ru/v1/news") { (data, error) in
            if let error = error {
                completion([], error)
            }
            if let data = data {
                DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                    let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()
                    context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
                    JSONMapper().mapJSONArray(data: data,
                                              key: "payload",
                                              entityClassName: "NewsTitleItem",
                                              context: context)
                    
                    do {
                        try context.save()
                        let fetchedNews = try self.fetchNews()
                        completion(fetchedNews, nil)
                    } catch(let error) {
                        completion([], error)
                    }
                }
            }
        }
    }
    
    func fetchNews(completion: @escaping ([NewsTitleItem], Error?) -> Void) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            do {
                let fetchedNews = try self.fetchNews()
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
        fetchRequest.fetchBatchSize = 10
        
        return try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
    }

}
