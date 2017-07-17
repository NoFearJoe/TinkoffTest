//
//  NewsContentPresenter.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//




final class NewsContentPresenter {

    var interactor: NewsContentInteractorInput!
    weak var view: NewsContentViewInput!

}

extension NewsContentPresenter: NewsContentViewOutput {

    func onAppear() {
        view.setLoading(true)
        interactor.obtainNewsContent()
    }

}

extension NewsContentPresenter: NewsContentModuleInput {

    func setNewsTitleItem(_ newsTitleItem: NewsTitleItem) {
        interactor.setNewsContent(newsTitleItem)
    }

}

extension NewsContentPresenter: NewsContentInteractorOutput {

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
