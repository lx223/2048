//
//  CollectionExtensions.swift
//  2048
//
//  Created by Lan Xiao on 23/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }

    func shuffled() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffle()
        return list
    }
}
