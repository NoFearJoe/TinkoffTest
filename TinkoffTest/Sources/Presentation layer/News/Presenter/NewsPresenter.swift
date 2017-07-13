//
//  NewsPresenter.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation


final class NewsPresenter {

    var interactor: NewsInteractor!
    var router: NewsRouter!
    weak var view: NewsView!
    
    
    func obtainNews() {
        interactor.obtainNews { [weak self] in
            self?.view.reloadNews()
        }
    }
    
    func didSelectNewsItem(_ newsItem: NewsTitleItem) {
        router.showNewsItem(newsItem)
    }

}
