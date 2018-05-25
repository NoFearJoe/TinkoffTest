//
//  NewsAssembly.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//


final class NewsAssembly {

    static func assembly(with view: NewsView) {
        let presenter = NewsPresenter()
        let viewDataSource = NewsDataSource()
        
        viewDataSource.itemsProvider = presenter
                
        presenter.view = view
        presenter.transitionHandler = view
        presenter.newsService = NewsService()
        
        view.output = presenter
        view.dataSource = viewDataSource
    }

}
