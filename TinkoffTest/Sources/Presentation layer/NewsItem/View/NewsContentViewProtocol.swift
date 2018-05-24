//
//  NewsContentViewProtocol.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import class Foundation.NSAttributedString

protocol NewsContentViewProtocol: NewsContentViewInput {
    var output: NewsContentViewOutput! { get set }
}

protocol NewsContentViewInput: class {
    func setLoading(_ loading: Bool)
    func showNewsContent(_ newsContent: NSAttributedString)
}

protocol NewsContentViewOutput: class {
    func onAppear()
}
