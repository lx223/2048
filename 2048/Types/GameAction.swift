//
//  GameAction.swift
//  2048
//
//  Created by Lan Xiao on 23/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import Foundation

enum GameAction {
    case randomSpawn
    case merge(Tile, Tile, atPosition: Position)
    case move(Tile, toPosition: Position)
}
