//
//  NewsInteractorProtocol.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

protocol NewsInteractorProtocol: NewsInteractorInput {
    var output: NewsInteractorOutput! { get set }
}


protocol NewsInteractorInput: class {
    func obtainNews()
    func reloadNews()
}

protocol NewsInteractorOutput: class {
    func didFetchNews(count: Int)
    func didObtainNews(count: Int)
    func didReceiveError(_ error: Error)
}
