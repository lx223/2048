//
//  AppState.swift
//  2048
//
//  Created by Lan Xiao on 23/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import Foundation

protocol AppStating {
    var currentScore: Int { get }
    var bestScore: Int { get }
    var boardSize: Int { get }
    var tiles: [[Int]] { get }
}

//struct AppState: AppStating {
//    var boardSize: Int
//
//    var tiles: [[Int]]
//
//    var currentScore: Int
//
//    var bestScore: Int
//
//
//}

