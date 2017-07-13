//
//  NewsAssembly.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation


final class NewsAssembly {

    static func assembly(with view: NewsView) {
        let interactor = NewsInteractor()
        let presenter = NewsPresenter()
        let viewDataSource = NewsDataSource()
        
        viewDataSource.itemsProvider = interactor
        
        presenter.interactor = interactor
        presenter.view = view
        
        view.output = presenter
        view.dataSource = viewDataSource
    }

}
