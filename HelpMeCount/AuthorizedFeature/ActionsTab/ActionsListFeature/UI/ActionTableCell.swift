//
//  ActionTableCell.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 28.01.2026.
//

import UIKit

class ActionTableCell: UITableViewCell {
    public static let identifier: String = "ActionTableCell"

    private let titleLabel: UILabel = .actionCellTitleLabel()
    private let countLabel: UILabel = .actionCellCountLabel()
    private let plusImage = UIImageView()
    private let subView = UIView()

    private var cellAction: CountableAction?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(subView)
        subView.addSubview(titleLabel)
        subView.addSubview(countLabel)
        subView.addSubview(plusImage)

        setupViews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setAction(action: CountableAction) {
        cellAction = action

        titleLabel.text = cellAction?.title
        countLabel.text = parseCount()
    }

    private func setupViews() {
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear

        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.backgroundColor = .trueWhite
        subView.layer.cornerRadius = 6

        plusImage.image = UIImage(named: "cross_image")
    }

    private func makeConstraints() {

        plusImage.snp.makeConstraints { currentView in
            currentView.top.equalTo(subView).offset(10)
            currentView.bottom.equalTo(subView).offset(-10)
            currentView.right.equalTo(subView)
        }

        subView.snp.makeConstraints { currentView in
            currentView.top.equalTo(contentView).offset(5)
            currentView.bottom.equalTo(contentView).offset(-5)
            currentView.left.equalTo(contentView).offset(12)
            currentView.right.equalTo(contentView).offset(-12)
        }

        titleLabel.snp.makeConstraints { currentView in
            currentView.top.equalTo(subView)
            currentView.centerY.equalTo(subView)
            currentView.left.equalTo(subView)
        }

        countLabel.snp.makeConstraints { currentView in
            currentView.centerX.equalTo(subView)
            currentView.bottom.equalTo(subView.snp.bottom)
        }
    }

    private func parseCount() -> String {
        guard let cellAction else { return "0 из 0" }
        return "\(cellAction.currentRepeats) из \(cellAction.maxRepeates)"
    }
}
