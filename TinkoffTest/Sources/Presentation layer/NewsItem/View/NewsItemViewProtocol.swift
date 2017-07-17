//
//  NewsItemViewProtocol.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import class Foundation.NSAttributedString


protocol NewsItemViewProtocol: class, NewsItemViewInput {
    var output: NewsItemViewOutput! { get set }
}

protocol NewsItemViewInput: class {
    func setLoading(_ loading: Bool)
    func showNewsContent(_ newsContent: NSAttributedString)
}

protocol NewsItemViewOutput: class {
    func onAppear()
}
