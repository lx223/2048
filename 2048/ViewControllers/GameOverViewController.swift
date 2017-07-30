//
//  GameOverViewController.swift
//  2048
//
//  Created by Lan Xiao on 21/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import UIKit

final class GameOverViewController: UIViewController {

    fileprivate let backdropView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: 0xeee4da, alpha: 0.7)
        return view
    }()

    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Game Over"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()

    let newGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Try Again", for: .normal)
        button.backgroundColor = UIColor(hex: 0x8f7a66)
        button.setTitleColor(UIColor(hex: 0xf9f6f2), for: .normal)
        button.layer.cornerRadius = 3
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.1
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.titleLabel?.baselineAdjustment = .alignCenters
        return button
    }()

    init() {
        super.init(nibName: nil, bundle: nil)

        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backdropView)
        backdropView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backdropView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backdropView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backdropView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        view.addSubview(titleLabel)
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true

        view.addSubview(newGameButton)
        newGameButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        newGameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
