//
//  NewsContentModuleAssembly.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 14.07.17.
//  Copyright © 2017 IK. All rights reserved.
//


final class NewsContentModuleAssembly {
    
    static func assembly(with view: NewsContentViewProtocol) -> NewsContentModuleInput {
        let interactor = NewsContentInteractor()
        let presenter = NewsContentPresenter()
        
        presenter.interactor = interactor
        presenter.view = view
        
        view.output = presenter
        
        interactor.output = presenter
        interactor.newsContentService = NewsContentService()
        
        return presenter
    }
    
}
