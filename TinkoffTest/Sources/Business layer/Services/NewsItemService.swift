//
//  NewsItemService.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//


final class NewsItemService {
    
    let requestManager = RequestManager()
    
    func obtainNewsItem(id: String, completion: @escaping (NewsContentItem) -> Void) {
        requestManager.request(path: "https://api.tinkoff.ru/v1/news_content", parameters: ["id": id]) { (data, error) in
            if let error = error {
                print(error)
            }
            if let data = data {
                
            }
        }
    }
    
}
