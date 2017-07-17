//
//  NewsItemInteractorProtocol.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//


protocol NewsItemInteractorProtocol: class, NewsItemInteractorInput {
    weak var output: NewsItemInteractorOutput! { get set }
}

protocol NewsItemInteractorInput: class {
    func setNewsItem(_ newsItem: NewsTitleItem)
    func obtainNewsContent()
}

protocol NewsItemInteractorOutput: class {
    func didLoadNewsContent(_ newsContent: NewsContentItem)
    func didReceiveError(_ error: Error)
}
