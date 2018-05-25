//
//  NewsInteractor.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation

protocol CachedNewsInteractor: class {
    var newsService: NewsServiceProtocol! { get }
    func fetchNews(completion: @escaping ([NewsTitleItem]?, Error?) -> Void)
}

extension CachedNewsInteractor {
    func fetchNews(completion: @escaping ([NewsTitleItem]?, Error?) -> Void) {
        newsService.fetchNews { news, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(news, error)
            }
        }
    }
}

extension CachedNewsInteractor where Self: Mock {
    func fetchNews(completion: @escaping ([NewsTitleItem]?, Error?) -> Void) {
        completion([], nil)
    }
}

protocol RemoteNewsInteractor: class {
    var newsService: NewsServiceProtocol! { get }
    func requestNews(completion: @escaping ([NewsTitleItem]?, Error?) -> Void)
}

extension RemoteNewsInteractor {
    func requestNews(completion: @escaping ([NewsTitleItem]?, Error?) -> Void) {
        newsService.loadNews { news, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(news, error)
            }
        }
    }
}
