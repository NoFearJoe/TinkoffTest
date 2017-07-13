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
    
    func obtainNews(completion: @escaping ([NewsTitleItem]) -> Void) {
        completion(fetchNews())
        requestManager.request(path: "https://api.tinkoff.ru/v1/news") { (data, error) in
            if let error = error {
                print(error)
            }
            if let data = data {
                DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async { [weak self] in
                    let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()
                    JSONMapper().mapJSONArray(data: data,
                                              key: "payload",
                                              entityClassName: "NewsTitleItem",
                                              context: context)
                    
                    self?.deleteOldNews(context: context) {
                        try! context.save()
                        
                        DispatchQueue.main.async { [weak self] in
                            let news = self?.fetchNews() ?? []
                            completion(news)
                        }
                    }
                }
            }
        }
    }
    
    func fetchNews() -> [NewsTitleItem] {
        let fetchRequest: NSFetchRequest<NewsTitleItem> = NewsTitleItem.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "publicationDate", ascending: false)
        ]
        
        return (try? CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)) ?? []
    }
    
    fileprivate func deleteOldNews(context: NSManagedObjectContext, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: NewsTitleItem.fetchRequest())
            let _ = try? context.execute(deleteRequest)
            
            completion()
        }
    }

}
