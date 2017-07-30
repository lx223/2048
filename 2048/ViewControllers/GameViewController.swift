//
//  GameViewController.swift
//  2048
//
//  Created by Lan Xiao on 17/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import UIKit

enum GameState {
    case scored(Int)
}

protocol GameStateChangeDelegate: class {
    func gameStateChanged(_ state: GameState)
}

final class GameViewController: UIViewController {

    fileprivate var tiles: [[TileView?]]
    fileprivate let boardSize: Int
    fileprivate let boardView: BoardView
    weak var delegate: GameStateChangeDelegate?

    init(boardSize: Int) {
        self.boardSize = boardSize
        tiles = Array(repeating: Array(repeating: nil, count: boardSize), count: boardSize)
        boardView = BoardView(size: boardSize)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addGestureRecognisers()
        configureViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startNewGame()
    }

    @objc func startNewGame() {
        for i in 0 ..< tiles.count {
            for j in 0 ..< tiles[i].count {
                tiles[i][j]?.removeFromSuperview()
                tiles[i][j] = nil
            }
        }

        execute([.randomSpawn, .randomSpawn])
    }

    @objc func restartButtonPressed() {
        dismiss(animated: true, completion: {
            self.startNewGame()
        })
    }
}

fileprivate extension GameViewController {
    func addGestureRecognisers() {
        let directions: [UISwipeGestureRecognizerDirection] = [.left, .right, .up, .down]
        directions.forEach {
            let recogniser = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
            recogniser.direction = $0
            boardView.addGestureRecognizer(recogniser)
        }
    }

    @objc func onSwipe(_ recogniser: UISwipeGestureRecognizer) {
        let actions = generateActions(forSwipe: recogniser.direction)
        execute(actions)

        if isGameOver() {
            showMenu()
        }
    }

    func configureViews() {
        view.addSubview(boardView)
        boardView.translatesAutoresizingMaskIntoConstraints = false
        boardView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        boardView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

fileprivate extension GameViewController {

    func generateActions(forSwipe swipe: UISwipeGestureRecognizerDirection) -> [GameAction] {
        var actions = [GameAction]()
        guard let swipeVector = swipe.toVector() else { return actions }

        let startingPositions: [Position] = (0 ..< boardSize).map {
            let edgePosition = (
                max(0, swipeVector.dx * (boardSize - 1)),
                max(0, swipeVector.dy * (boardSize - 1))
            )
            let advanceVector: Vector = (abs(swipeVector.dy), abs(swipeVector.dx))
            return (edgePosition.0 + advanceVector.dx * $0, edgePosition.1 + advanceVector.dy * $0)
        }
        
        startingPositions.forEach {
            let reverseDirection: Vector = (-swipeVector.dx, -swipeVector.dy)
            var endPosition: Position = $0
            
            let availableTiles: [Tile] = (0 ..< boardSize).flatMap {
                let x = endPosition.x + $0 * reverseDirection.dx
                let y = endPosition.y + $0 * reverseDirection.dy
                guard let tile = tiles[x][y] else { return nil }
                return (tile.number, (x, y))
            }
            
            guard !availableTiles.isEmpty else { return }
            var i = 0
            while i < availableTiles.count {
                let currentTile = availableTiles[i]
                if let nextTile = availableTiles[safe: i + 1], currentTile.value == nextTile.value {
                    actions.append(.merge(currentTile, nextTile, atPosition: endPosition))
                    i += 1
                } else if currentTile.position != endPosition {
                    actions.append(.move(currentTile, toPosition: endPosition))
                }
                i += 1
                endPosition = (endPosition.x + reverseDirection.dx, endPosition.y + reverseDirection.dy)
            }
        }

        if !actions.isEmpty {
            actions.append(.randomSpawn)
        }

        return actions
    }

    func execute(_ actions: [GameAction]) {
        actions.forEach {
            switch $0 {
            case let .merge(tile1, tile2, position):
                delegate?.gameStateChanged(.scored(tile1.value + tile2.value))
                executeMerge(tile1: tile1, tile2: tile2, atPosition: position)
            case let .move(tile, position):
                executeMove(tile: tile, toPosition: position)
            case .randomSpawn:
                executeSpawn()
            }
        }
    }

    func executeMerge(tile1: Tile, tile2: Tile, atPosition position: Position) {
        let tileView1 = tiles[tile1.position.x][tile1.position.y]
        let tileView2 = tiles[tile2.position.x][tile2.position.y]
        tiles[tile1.position.x][tile1.position.y] = nil
        tiles[tile2.position.x][tile2.position.y] = nil

        let targetFrame = boardView.frameForSlot(atPosition: position)
        let mergeTileView = TileView(number: tile1.value + tile2.value, withFrame: targetFrame)
        tiles[position.x][position.y] =  mergeTileView

        boardView.addSubview(mergeTileView)
        UIView.animate(withDuration: 0.15, animations: {
            tileView1?.frame = targetFrame
            tileView2?.frame = targetFrame
        })

        UIView.animate(withDuration: 0.05, delay: 0.1, options: [], animations: {
            tileView1?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            tileView2?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            mergeTileView.transform = CGAffineTransform.identity
        }) { _ in
            tileView1?.removeFromSuperview()
            tileView2?.removeFromSuperview()
        }
    }

    func executeMove(tile: Tile, toPosition position: Position) {
        let tileView = tiles[tile.position.x][tile.position.y]
        tiles[tile.position.x][tile.position.y] = nil
        tiles[position.x][position.y] = tileView

        let targetFrame = boardView.frameForSlot(atPosition: position)
        UIView.animate(withDuration: 0.2) {
            tileView?.frame = targetFrame
        }
    }

    func executeSpawn() {
        guard let freeTile: Tile = tiles
            .flatMap({ $0 })
            .enumerated()
            .filter({ $1 == nil })
            .map({
                let randomNumber = generateRandomStartNumber()
                let x = $0.offset / boardSize, y = $0.offset % boardSize
                return (randomNumber, (x, y))
            }).randomElement() else { return }

        let targetFrame = boardView.frameForSlot(atPosition: freeTile.position)
        let tileView = TileView(number: freeTile.value, withFrame: targetFrame)
        tiles[freeTile.position.x][freeTile.position.y] = tileView

        boardView.addSubview(tileView)
        UIView.animate(withDuration: 0.2, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: [], animations: {
            tileView.transform = .identity
        }, completion: nil)
    }

    func generateRandomStartNumber() -> Int {
        let random = Int.random(between: 1 ... 10)
        if random <= 8 {
            return 2
        } else {
            return 4
        }
    }

    func isGameOver() -> Bool {
        let hasFreeTile = tiles.flatMap{ $0 }.contains(where: { $0 == nil })
        return !hasFreeTile && !hasAvailableMoves
    }

    var hasAvailableMoves: Bool {
        for i in 0 ..< boardSize - 1 {
            for j in 0 ..< boardSize - 1 {
                guard let tile = tiles[i][j],
                    let downNeighbour = tiles[i][j + 1],
                    let rightNeighbour = tiles[i + 1][j] else { continue }
                if tile.number == downNeighbour.number || tile.number == rightNeighbour.number {
                    return true
                }
            }
        }
        return false
    }

    func showMenu() {
        let gameOverViewController = GameOverViewController()
        gameOverViewController.newGameButton.addTarget(self, action: #selector(restartButtonPressed), for: .touchUpInside)
        present(gameOverViewController, animated: true, completion: nil)
    }
}
