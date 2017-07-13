//
//  NewsDataSource.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import UIKit


protocol NewsItemsProvider {
    var itemsCount: Int { get }
    func item(at index: Int) -> NewsTitleItem?
}


final class NewsDataSource: NSObject {
    
    var itemsProvider: NewsItemsProvider!
    
    var didSelectNewsItem: ((NewsTitleItem) -> Void)?

}

extension NewsDataSource: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsProvider.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsItemCell", for: indexPath)
        
        cell.textLabel?.text = itemsProvider.item(at: indexPath.row)?.text
        
        return cell
    }

}

extension NewsDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newsItem = itemsProvider.item(at: indexPath.row) {
            didSelectNewsItem?(newsItem)
        }
    }

}
