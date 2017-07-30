//
//  MutableCollectionExtensions.swift
//  2048
//
//  Created by Lan Xiao on 30/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import Foundation

extension MutableCollection where Index == Int {

    mutating func shuffle() {
        guard count > 1 else { return }

        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            if i != j {
                swap(&self[i], &self[j])
            }
        }
    }
}
