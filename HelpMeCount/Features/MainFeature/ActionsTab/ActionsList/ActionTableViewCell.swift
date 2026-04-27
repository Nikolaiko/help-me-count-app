//
//  ActionTableViewCell.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 23.03.2026.
//

import UIKit

class ActionTableViewCell: UITableViewCell {
    public static let identifier: String = "ActionTableViewCell"

    private let titleLabel: UILabel = {
        let result = UILabel()
        result.font = UIFont.Roboto.regular(size: 14.0)
        result.textColor = .trueBlack
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()

    private let countLabel: UILabel = {
        let result = UILabel()
        result.font = UIFont.Roboto.regular(size: 14.0)
        result.textColor = .gray
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()

    private let plusImage = UIImageView()
    private let subView = UIView()

    private var cellAction: CountableAction? = nil

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
        fatalError("init?(coder: NSCoder) has not implemented")
    }

    func setAction(action: CountableAction) {
        cellAction = action

        titleLabel.text = action.title
        countLabel.text = parseCount()
    }

    private func setupViews() {
        contentView.backgroundColor = .clear

        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.backgroundColor = .trueWhite
        subView.layer.cornerRadius = 6

        plusImage.image = UIImage(named: "cross_image")
    }

    private func makeConstraints() {
        plusImage.snp.makeConstraints { imageView in
            imageView.top.equalTo(subView).offset(10)
            imageView.bottom.equalTo(subView).offset(-10)
            imageView.right.equalTo(subView)
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
            currentView.leading.equalTo(subView)
        }

        countLabel.snp.makeConstraints { currentView in
            currentView.centerX.equalTo(subView)
            currentView.bottom.equalTo(subView.snp.bottom)
        }
    }

    private func parseCount() -> String {
        guard let cellAction else { return "0 bз 0" }
        return "\(cellAction.currentRepeats) из \(cellAction.maxRepeats)"
    }
}
