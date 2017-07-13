//
//  NewsView.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import UIKit


final class NewsView: UIViewController {

    @IBOutlet fileprivate(set) weak var tableView: UITableView!
    
    @IBOutlet fileprivate var dataSource: NewsDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarTitleIcon()
        
//        dataSource.didSelectItem = 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    fileprivate func setupNavigationBarTitleIcon() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "Logo"))
    }

}
