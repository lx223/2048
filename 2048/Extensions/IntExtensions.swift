//
//  IntExtensions.swift
//  2048
//
//  Created by Lan Xiao on 20/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import Foundation

extension Int {
    static func random(between range: CountableClosedRange<Int>) -> Int {
        let diff = range.upperBound - range.lowerBound
        let randomOffset = Int(arc4random_uniform(UInt32(diff)))
        return range.lowerBound + randomOffset
    }
}
