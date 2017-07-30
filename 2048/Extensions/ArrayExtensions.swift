//
//  ArrayExtensions.swift
//  2048
//
//  Created by Lan Xiao on 20/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import Foundation

extension Array {
    func randomElement() -> Element? {
        guard count > 0 else { return nil }
        let randomIndex = Int(arc4random_uniform(UInt32(count)))
        return self[randomIndex]
    }
}
