//
//  ScoreView.swift
//  2048
//
//  Created by Lan Xiao on 18/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import UIKit

final class ScoreView: UIView {

    var score: Int = 0 {
        didSet {
            guard score >= 0 else { return }
            scoreLabel.text = "\(score)"
        }
    }

    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3, compatibleWith: nil)
        label.textAlignment = .center
        label.textColor = UIColor(hex: 0xeee4da)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()

    fileprivate let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3, compatibleWith: nil)
        label.textAlignment = .center
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()

    init(title: String, score: Int = 0, frame: CGRect = .zero) {
        super.init(frame: frame)

        self.score = score
        titleLabel.text = title
        scoreLabel.text = "\(score)"
        onInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func onInit() {
        backgroundColor = UIColor(hex: 0xbbada0)
        layer.cornerRadius = 20

        addSubview(titleLabel)
        addSubview(scoreLabel)

        titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true

        scoreLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        scoreLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        scoreLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
    }
}
