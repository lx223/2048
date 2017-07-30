//
//  UIColorExtensions.swift
//  2048
//
//  Created by Lan Xiao on 25/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex >> 16) & 0xFF)
        let green = CGFloat((hex >> 8) & 0xFF)
        let blue = CGFloat(hex & 0xFF)
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
}
