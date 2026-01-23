//
//  ScreenTopTitleView.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 04.01.2026.
//

import UIKit

class ScreenTopTitleView: UIView {

    private let titleLabel: UILabel = .screenTitle(text: "Default")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        createConstrainsts()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        createConstrainsts()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.layoutSubviews()

        backgroundColor = .red
    }

    public func setTitle(title: String) {
        titleLabel.text = title
    }

    private func setupView() {
        addSubview(titleLabel)

    }

    private func createConstrainsts() {
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
