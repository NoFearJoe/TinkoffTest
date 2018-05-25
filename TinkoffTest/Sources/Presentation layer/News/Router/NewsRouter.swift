//
//  NewsRouter.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import UIKit

protocol Route: class {
    var transitionHandler: TransitionHandler! { get }
}

protocol NewsItemRoute: Route {
    func showNewsItem(_ newsItem: NewsTitleItem)
}

extension NewsItemRoute {
    func showNewsItem(_ newsItem: NewsTitleItem) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsContentView")
        if let newsItemViewController = viewController as? NewsContentViewProtocol {
            let moduleInput = NewsContentModuleAssembly.assembly(with: newsItemViewController)
            moduleInput.setNewsTitleItem(newsItem)
        }
        transitionHandler.pushModule(with: viewController, animated: true)
    }
}
