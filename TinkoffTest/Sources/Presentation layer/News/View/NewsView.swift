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
    
    var dataSource: NewsDataSource!
    
    
    var output: NewsPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        setupNavigationBarTitleIcon()
        
        dataSource.didSelectNewsItem = output.didSelectNewsItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output.obtainNews()
    }
    
    
    fileprivate func setupNavigationBarTitleIcon() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "Logo"))
    }
    
    
    func reloadNews() {
        tableView.reloadData()
    }

}
