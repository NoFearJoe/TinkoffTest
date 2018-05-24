//
//  NewsContentInteractorProtocol.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//


protocol NewsContentInteractorProtocol: NewsContentInteractorInput {
    var output: NewsContentInteractorOutput! { get set }
}

protocol NewsContentInteractorInput: class {
    func setNewsContent(_ newsItem: NewsTitleItem)
    func obtainNewsContent()
}

protocol NewsContentInteractorOutput: class {
    func didLoadNewsContent(_ newsContent: NewsContentItem)
    func didReceiveError(_ error: Error)
}
