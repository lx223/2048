//
//  TileView.swift
//  2048
//
//  Created by Lan Xiao on 18/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import UIKit

final class TileView: UIView {

    let number: Int

    fileprivate let backgroundColours: [UIColor] = [
        UIColor(hex: 0xeee4da), // 2
        UIColor(hex: 0xede0c8), // 4
        UIColor(hex: 0xf2b179), // 8
        UIColor(hex: 0xf59563), // 16
        UIColor(hex: 0xf67c5f), // 32
        UIColor(hex: 0xf65e3b), // 64
        UIColor(hex: 0xedcf72), // 128
        UIColor(hex: 0xedcc61), // 256
        UIColor(hex: 0xedc850), // 512
        UIColor(hex: 0xedc53f), // 1024
        UIColor(hex: 0xedc22e), // 2048
        UIColor(hex: 0x3c3a32)  // beyond
    ]

    fileprivate let textColours: [UIColor] = [
        UIColor(hex: 0x776e65),
        UIColor(hex: 0x776e65),
        UIColor(hex: 0xf9f6f2)
    ]

    fileprivate let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        label.baselineAdjustment = .alignCenters
        return label
    }()

    fileprivate let popScale: CGFloat = 0
    fileprivate let animationDuration: Double = 0.2

    init(number: Int, withFrame frame: CGRect = .zero) {
        self.number = number
        super.init(frame: frame)

        onInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

fileprivate extension TileView {
    func onInit() {
        numberLabel.text = "\(number)"
        backgroundColor = backgroundColour(forNumber: number)
        numberLabel.textColor = textColour(forNumber: number)
        layer.cornerRadius = 5

        addSubview(numberLabel)
        numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    }

    func backgroundColour(forNumber num: Int) -> UIColor? {
        let index = Int(log2(CGFloat(num))) - 1
        guard index >= 0 && index < backgroundColours.count else { return backgroundColours.last }

        return backgroundColours[index]
    }

    func textColour(forNumber num: Int) -> UIColor? {
        let index = Int(log2(CGFloat(num))) - 1
        guard index >= 0 && index < textColours.count else { return textColours.last }

        return textColours[index]
    }
}

extension TileView {
    func animateShow() {
        UIView.animate(withDuration: animationDuration, delay: animationDuration, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: [], animations: {
           self.transform = .identity
        }, completion: nil)
    }
}
