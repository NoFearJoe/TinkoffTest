//
//  NewsItemPresenter.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//




final class NewsItemPresenter {

    var interactor: NewsItemInteractorInput!
    weak var view: NewsItemViewInput!

}

extension NewsItemPresenter: NewsItemViewOutput {

    func onAppear() {
        view.setLoading(true)
        interactor.obtainNewsContent()
    }

}

extension NewsItemPresenter: NewsItemModuleInput {

    func setNewsTitleItem(_ newsTitleItem: NewsTitleItem) {
        interactor.setNewsItem(newsTitleItem)
    }

}

extension NewsItemPresenter: NewsItemInteractorOutput {

    func didLoadNewsContent(_ newsContent: NewsContentItem) {
        if let content = newsContent.content?.fromHTML() {
            view.showNewsContent(content)
            view.setLoading(false)
        }
    }
    
    func didReceiveError(_ error: Error) {
        view.setLoading(false)
        print(error)
    }

}
