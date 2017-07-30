//
//  UISwipeGestureRecognizerDirectionExtensions.swift
//  2048
//
//  Created by Lan Xiao on 23/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import Foundation
import UIKit

extension UISwipeGestureRecognizerDirection {
    func toVector() -> Vector? {
        switch self {
        case UISwipeGestureRecognizerDirection.up:
            return (0, -1)
        case UISwipeGestureRecognizerDirection.left:
            return (-1, 0)
        case UISwipeGestureRecognizerDirection.right:
            return (1, 0)
        case UISwipeGestureRecognizerDirection.down:
            return (0, 1)
        default:
            return nil
        }
    }
}
