//
//  NewsViewProtocol.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//


protocol NewsViewProtocol: class, NewsViewInput, TransitionHandler {
    var output: NewsViewOutput! { get }
}

protocol NewsViewInput: class {
    func reloadNews()
    func setLoading(_ loading: Bool)
}

protocol NewsViewOutput: class {
    func onAppear()
    func onRefresh()
    func didSelectNewsItem(_ newsItem: NewsTitleItem)
}
