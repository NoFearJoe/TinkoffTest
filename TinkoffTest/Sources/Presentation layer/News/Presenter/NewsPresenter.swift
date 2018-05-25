//
//  NewsPresenter.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation

protocol Mock: class {}

final class NewsPresenter: CachedNewsInteractor, RemoteNewsInteractor, NewsItemRoute, Mock {

    weak var view: NewsViewInput!
    weak var transitionHandler: TransitionHandler!
    
    var newsService: NewsServiceProtocol!
    
    private var news: [NewsTitleItem] = []

}

extension NewsPresenter: NewsViewOutput {

    func onAppear() {
        view.setLoading(true)
        fetchNews()
        requestNews()
    }
    
    func onRefresh() {
        view.setLoading(true)
        requestNews()
    }
    
    func didSelectNewsItem(_ newsItem: NewsTitleItem) {
        showNewsItem(newsItem)
    }

}

extension NewsPresenter {

    func fetchNews() {
        fetchNews { [weak self] news, error in
            if let news = news {
                self?.news = news
                self?.view.reloadNews()
                if news.count > 0  {
                    self?.view.setLoading(false)
                }
            } else {
                self?.view.setLoading(false)
            }
        }
    }
    
    func requestNews() {
        requestNews { [weak self] news, error in
            if let news = news {
                self?.news = news
                self?.view.reloadNews()
                self?.view.setLoading(false)
            } else {
                self?.view.setLoading(false)
            }
        }
    }

}

extension NewsPresenter: NewsItemsProvider {
    
    var itemsCount: Int {
        return news.count
    }
    
    func item(at index: Int) -> NewsTitleItem? {
        guard news.indices.contains(index) else { return nil }
        return news[index]
    }
    
}
