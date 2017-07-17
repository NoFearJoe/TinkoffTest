//
//  NewsItemInteractor.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//


enum NewsItemInteractorError: Error {
    case noData
}


final class NewsItemInteractor: NewsItemInteractorProtocol {

    weak var output: NewsItemInteractorOutput!
    
    var newsItemService: NewsItemService = NewsItemService()
    
    fileprivate var newsItem: NewsTitleItem!
    
    
    fileprivate func handleNewsContentResponse(newsContent: NewsContentItem?, error: Error?) {
        if let error = error {
            self.output.didReceiveError(error)
        } else if let newsContent = newsContent {
            self.output.didLoadNewsContent(newsContent)
        } else {
            self.output.didReceiveError(NewsItemInteractorError.noData)
        }
    }

}

extension NewsItemInteractor: NewsItemInteractorInput {

    func setNewsItem(_ newsItem: NewsTitleItem) {
        self.newsItem = newsItem
    }
    
    func obtainNewsContent() {
        if let id = newsItem.id {
            newsItemService.fetchNewsContent(id: id, completion: { [weak self] (newsContent, error) in
                self?.handleNewsContentResponse(newsContent: newsContent, error: error)
            })
            newsItemService.obtainNewsContent(newsTitleID: id) { [weak self] newsContent, error in
                self?.handleNewsContentResponse(newsContent: newsContent, error: error)
            }
        } else {
            output.didReceiveError(NewsItemInteractorError.noData)
        }
    }

}
