//
//  NewsPresenter.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation


final class NewsPresenter {

    var interactor: NewsInteractorInput!
    var router: NewsRouterInput!
    weak var view: NewsViewInput!

}

extension NewsPresenter: NewsViewOutput {

    func onAppear() {
        view.setLoading(true)
        interactor.obtainNews()
    }
    
    func onRefresh() {
        view.setLoading(true)
        interactor.reloadNews()
    }
    
    func didSelectNewsItem(_ newsItem: NewsTitleItem) {
        router.showNewsItem(newsItem)
    }

}

extension NewsPresenter: NewsInteractorOutput {

    func didFetchNews(count: Int) {
        view.reloadNews()
        if count > 0  {
            view.setLoading(false)
        }
    }
    
    func didObtainNews(count: Int) {
        view.reloadNews()
        view.setLoading(false)
    }
    
    func didReceiveError(_ error: Error) {
        view.setLoading(false)
    }

}
