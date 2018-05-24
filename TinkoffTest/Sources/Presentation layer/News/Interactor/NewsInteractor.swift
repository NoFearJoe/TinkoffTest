//
//  NewsInteractor.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation


final class NewsInteractor: NewsInteractorProtocol {

    weak var output: NewsInteractorOutput!
    var newsService: NewsServiceProtocol!
    
    private var news: [NewsTitleItem] = []

}

extension NewsInteractor: NewsInteractorInput {

    func obtainNews() {
        newsService.fetchNews { [weak self] (news, error) in
            guard let `self` = self else { return }
            
            if let error = error {
                self.output.didReceiveError(error)
            } else {
                self.news = news
                self.output.didFetchNews(count: news.count)
            }
        }
        reloadNews()
    }
    
    func reloadNews() {
        newsService.loadNews { [weak self] (news, error) in
            guard let `self` = self else { return }
            
            if let error = error {
                self.output.didReceiveError(error)
            } else {
                self.news = news
                self.output.didObtainNews(count: news.count)
            }
        }
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
