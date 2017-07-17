//
//  AsyncMap.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 14.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import Foundation

class Async<I, O> {
    func mapAsync(
        items: [I],
        iterator: @escaping (I, @escaping (NSError?, O) -> ()) -> (),
        complete: @escaping (NSError?, [O]) -> ()
        ) {
        let queue = DispatchQueue(label: "asd")
        
        _map(items: items, complete: complete) { item, callback in
            queue.async {
                iterator(item, callback)
            }
        }
    }
}

func _map<I, O>(
    items: [I],
    complete: @escaping (NSError?, [O]) -> (),
    iterator: (I, @escaping (NSError?, O) -> ()) -> ()
    ) {
    var ongoing = [Int: O]()
    
    for (i, _) in items.enumerated() {
        iterator(items[i]) { err, result in
            ongoing[i] = result
            
            if err != nil || ongoing.count == items.count {
                let results = Array(ongoing.keys)
                    .map({ (index: $0, passed: ongoing[$0]!) })
                    .sorted(by: { $0.0 < $1.0 }).map({ $0.1 })
                complete(err, results)
            }
        }
    }
}
