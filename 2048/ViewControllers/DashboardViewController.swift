//
//  DashboardViewController.swift
//  2048
//
//  Created by Lan Xiao on 17/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import UIKit

final class DashboardViewController: UIViewController {

    fileprivate var logoLabelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.text = "2048"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textAlignment = .center
        label.textColor = UIColor(hex: 0x776e65)

        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        view.layer.cornerRadius = 20
        return view
    }()

    let newGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("NEW GAME", for: .normal)
        button.backgroundColor = UIColor(hex: 0x8f7a66)
        button.setTitleColor(UIColor(hex: 0xf9f6f2), for: .normal)
        button.layer.cornerRadius = 3
        return button
    }()

    fileprivate var bestScoreView: ScoreView = {
        let view = ScoreView(title: "BEST")
        view.translatesAutoresizingMaskIntoConstraints = false

        if let bestScoreString = UserDefaults.standard.string(forKey: "2048.bestscore"),
            let bestScore = Int(bestScoreString) {
            view.score = bestScore
        }
        return view
    }()

    fileprivate var currentScoreView: ScoreView = {
        let view = ScoreView(title: "SCORE")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        configureLayouts()
    }

    func addScore(_ score: Int) {
        currentScoreView.score += score

        if currentScoreView.score > bestScoreView.score {
            bestScoreView.score = currentScoreView.score

            UserDefaults.standard.set(bestScoreView.score, forKey: "2048.bestscore")
        }
    }

}

fileprivate extension DashboardViewController {

    func configureViews() {
        view.addSubview(logoLabelView)
        view.addSubview(newGameButton)
        view.addSubview(bestScoreView)
        view.addSubview(currentScoreView)
    }

    func configureLayouts() {
        logoLabelView.centerXAnchor.constraint(equalTo: bestScoreView.centerXAnchor).isActive = true
        logoLabelView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        logoLabelView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        logoLabelView.widthAnchor.constraint(equalTo: logoLabelView.heightAnchor).isActive = true

        newGameButton.centerXAnchor.constraint(equalTo: currentScoreView.centerXAnchor).isActive = true
        newGameButton.centerYAnchor.constraint(equalTo: logoLabelView.centerYAnchor).isActive = true
        newGameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true

        bestScoreView.topAnchor.constraint(equalTo: logoLabelView.bottomAnchor).isActive = true
        bestScoreView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        bestScoreView.widthAnchor.constraint(equalTo: currentScoreView.widthAnchor).isActive = true

        currentScoreView.centerYAnchor.constraint(equalTo: bestScoreView.centerYAnchor).isActive = true
        currentScoreView.leadingAnchor.constraint(equalTo: bestScoreView.trailingAnchor, constant: 8).isActive = true
        currentScoreView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }
}
