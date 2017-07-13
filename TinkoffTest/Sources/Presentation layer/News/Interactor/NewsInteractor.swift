//
//  NewsInteractor.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import CoreData


final class NewsInteractor {

    var newsService: NewsService = NewsService()
    
    var news: [NewsTitleItem] = []
    
    func obtainNews(completion: @escaping () -> Void) {
        newsService.obtainNews(completion: { [weak self] news in
            self?.news = news
            completion()
        })
    }

}

extension NewsInteractor: NewsItemsProvider {

    var itemsCount: Int {
        return news.count
    }
    
    func item(at index: Int) -> NewsTitleItem? {
        if news.indices.contains(index) {
            return news[index]
        }
        return nil
    }

}
