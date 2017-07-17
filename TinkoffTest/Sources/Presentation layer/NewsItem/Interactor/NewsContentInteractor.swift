//
//  NewsContentInteractor.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//


enum NewsContentInteractorError: Error {
    case noData
}


final class NewsContentInteractor: NewsContentInteractorProtocol {

    weak var output: NewsContentInteractorOutput!
    var newsContentService: NewsContentServiceProtocol!
    
    fileprivate var newsItem: NewsTitleItem!
    
    
    fileprivate func handleNewsContentResponse(newsContent: NewsContentItem?, error: Error?) {
        if let error = error {
            self.output.didReceiveError(error)
        } else if let newsContent = newsContent {
            self.output.didLoadNewsContent(newsContent)
        } else {
            self.output.didReceiveError(NewsContentInteractorError.noData)
        }
    }

}

extension NewsContentInteractor: NewsContentInteractorInput {

    func setNewsContent(_ newsItem: NewsTitleItem) {
        self.newsItem = newsItem
    }
    
    func obtainNewsContent() {
        if let id = newsItem.id {
            newsContentService.fetchNewsContent(id: id, completion: { [weak self] (newsContent, error) in
                self?.handleNewsContentResponse(newsContent: newsContent, error: error)
            })
            newsContentService.obtainNewsContent(newsTitleID: id) { [weak self] newsContent, error in
                self?.handleNewsContentResponse(newsContent: newsContent, error: error)
            }
        } else {
            output.didReceiveError(NewsContentInteractorError.noData)
        }
    }

}
