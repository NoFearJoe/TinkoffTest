//
//  NewsDataSource.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import UIKit


final class NewsDataSource: NSObject {

    var newsItems: [Any] = []
    
    var didSelectItem: ((Int) -> Void)?

}

extension NewsDataSource: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsItemCell", for: indexPath)
        
        cell.textLabel?.text = "asd"
        
        return cell
    }

}

extension NewsDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItem?(indexPath.row)
    }

}
