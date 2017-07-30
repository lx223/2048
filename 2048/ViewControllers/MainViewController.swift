//
//  MainViewController.swift
//  2048
//
//  Created by Lan Xiao on 17/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    fileprivate var gameViewController = GameViewController(boardSize: 4)
    fileprivate var dashboardViewController = DashboardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: 0xfaf8ef)
        embedChildViewControllers()

        gameViewController.delegate = self
        dashboardViewController.newGameButton.addTarget(self, action: #selector(onNewGameButtonPressed), for: .touchUpInside)
    }

    @objc func onNewGameButtonPressed() {
        gameViewController.startNewGame()
    }
}

fileprivate extension MainViewController {
    func embedChildViewControllers() {
        addChildViewController(dashboardViewController)
        view.addSubview(dashboardViewController.view)
        dashboardViewController.didMove(toParentViewController: self)

        addChildViewController(gameViewController)
        view.addSubview(gameViewController.view)
        gameViewController.didMove(toParentViewController: self)

        dashboardViewController.view.translatesAutoresizingMaskIntoConstraints = false
        dashboardViewController.view.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        dashboardViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dashboardViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dashboardViewController.view.bottomAnchor.constraint(equalTo: gameViewController.view.topAnchor).isActive = true

        gameViewController.view.translatesAutoresizingMaskIntoConstraints = false
        gameViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gameViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        gameViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        gameViewController.view.heightAnchor.constraint(equalTo: gameViewController.view.heightAnchor).isActive = true
    }
}

extension MainViewController: GameStateChangeDelegate {
    func gameStateChanged(_ state: GameState) {
        guard case let .scored(score) = state else { return }
        dashboardViewController.addScore(score)
    }
}
