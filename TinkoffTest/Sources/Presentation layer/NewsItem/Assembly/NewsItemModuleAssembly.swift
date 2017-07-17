//
//  NewsItemModuleAssembly.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 14.07.17.
//  Copyright © 2017 IK. All rights reserved.
//


final class NewsItemModuleAssembly {
    
    static func assembly(with view: NewsItemViewProtocol) -> NewsItemModuleInput {
        let interactor = NewsItemInteractor()
        let presenter = NewsItemPresenter()
        
        presenter.interactor = interactor
        presenter.view = view
        
        view.output = presenter
        
        interactor.output = presenter
        
        return presenter
    }
    
}
