//
//  NewsRouter.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import UIKit


final class NewsRouter: NewsRouterInput {

    var transitionHandler: TransitionHandler!
    
    func showNewsItem(_ newsItem: NewsTitleItem) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsContentView")
        if let newsItemViewController = viewController as? NewsContentViewProtocol {
            let moduleInput = NewsContentModuleAssembly.assembly(with: newsItemViewController)
            moduleInput.setNewsTitleItem(newsItem)
        }
        transitionHandler.pushModule(with: viewController, animated: true)
    }

}
