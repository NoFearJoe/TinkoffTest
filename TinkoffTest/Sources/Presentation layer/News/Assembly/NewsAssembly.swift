//
//  NewsAssembly.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//


final class NewsAssembly {

    static func assembly(with view: NewsView) {
        let interactor = NewsInteractor()
        let presenter = NewsPresenter()
        let router = NewsRouter()
        let viewDataSource = NewsDataSource()
        
        viewDataSource.itemsProvider = interactor
        
        router.transitionHandler = view
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        view.output = presenter
        view.dataSource = viewDataSource
        
        interactor.output = presenter
        interactor.newsService = NewsService()
    }

}
