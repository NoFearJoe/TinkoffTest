//
//  NewsView.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import UIKit


final class NewsView: UIViewController, NewsViewProtocol {

    @IBOutlet fileprivate(set) weak var tableView: UITableView!
    
    fileprivate let refreshControl = UIRefreshControl()
    
    var dataSource: NewsDataSource!
    
    
    var output: NewsViewOutput!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        setupNavigationBarTitleIcon()
        setupRefreshControl()
        
        dataSource.didSelectNewsItem = output.didSelectNewsItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output.onAppear()
    }
    
    
    fileprivate func setupNavigationBarTitleIcon() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "Logo"))
    }
    
    fileprivate func setupRefreshControl() {
        refreshControl.addTarget(self,
                                 action: #selector(NewsView.refresh),
                                 for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func refresh() {
        refreshControl.beginRefreshing()
        output.onRefresh()
    }

}

extension NewsView: NewsViewInput {

    func reloadNews() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func setLoading(_ loading: Bool) {
        DispatchQueue.main.async { [weak self] in
            loading ? self?.showLoading() : self?.hideLoading()
            if !loading && self?.refreshControl.isRefreshing == true {
                self?.refreshControl.endRefreshing()
            }
        }
    }

}
