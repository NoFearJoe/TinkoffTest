//
//  NewsInteractorProtocol.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

protocol NewsInteractorProtocol: class, NewsInteractorInput {
    weak var output: NewsInteractorOutput! { get set }
}


protocol NewsInteractorInput: class {
    func obtainNews()
    func reloadNews()
}

protocol NewsInteractorOutput: class {
    func didFetchNews()
    func didObtainNews()
    func didReceiveError(_ error: Error)
}
