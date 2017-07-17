//
//  NewsItemView.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import UIKit
import class Foundation.NSAttributedString


final class NewsItemView: UIViewController, NewsItemViewProtocol {

    @IBOutlet fileprivate(set) weak var contentView: UITextView!
    
    var output: NewsItemViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarTitleIcon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output.onAppear()
    }

    fileprivate func setupNavigationBarTitleIcon() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "Logo"))
    }
    
}

extension NewsItemView: NewsItemViewInput {

    func setLoading(_ loading: Bool) {
        DispatchQueue.main.async {
            loading ? self.showLoading() : self.hideLoading()
        }
    }
    
    func showNewsContent(_ newsContent: NSAttributedString) {
        DispatchQueue.main.async {
            self.contentView.attributedText = newsContent
        }
    }

}
