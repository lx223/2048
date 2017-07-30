//
//  BoardView.swift
//  2048
//
//  Created by Lan Xiao on 18/07/2017.
//  Copyright © 2017 Lan Xiao. All rights reserved.
//

import UIKit

final class BoardView: UIView {

    fileprivate let size: Int
    fileprivate let slotViews: [UIView]
    fileprivate let rowStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }()

    init(size: Int) {
        self.size = size
        slotViews = (0..<(size * size)).map({ _ -> UIView in
            let view = UIView()
            view.backgroundColor = UIColor(hex: 0xeee4da, alpha: 0.35)
            view.layer.cornerRadius = 5
            return view
        })
        super.init(frame: .zero)

        onInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func frameForSlot(atPosition position: (Int, Int)) -> CGRect {
        let (row, col) = position
        let rowFrame = rowStackView.arrangedSubviews[col].frame
        let itemFrame = slotViews[col * size + row].frame

        let x = rowFrame.origin.x + itemFrame.origin.x + 8
        let y = rowFrame.origin.y + itemFrame.origin.y + 8
        let width = itemFrame.width
        let height = itemFrame.height
        return CGRect(x: x, y: y, width: width, height: height)
    }

}

fileprivate extension BoardView {
    func onInit() {
        backgroundColor = UIColor(hex: 0xbbada0)
        widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        layer.cornerRadius = 5

        (0..<size).map({ $0 * size }).forEach({
            let stackView = UIStackView(arrangedSubviews: Array(slotViews[$0..<($0 + size)]))
            stackView.spacing = 8
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            rowStackView.addArrangedSubview(stackView)
        })

        addSubview(rowStackView)
        rowStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        rowStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        rowStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        rowStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
}

