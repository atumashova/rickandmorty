//
//  CharacterInfoCell.swift
//  RickAndMorty
//
//  Created by Ann on 15.12.2024.
//

import Foundation
import UIKit

final class CharacterInfoCell: UITableViewCell {
    static let reuseIdentifier = "CharacterInfoCell"
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.theme.characterInfoTitle
        label.textColor = UIColor.theme.characterDarkText
        label.textAlignment = .left
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.theme.characterInfoDescription
        label.textColor = UIColor.theme.characterText
        label.textAlignment = .left
        return label
    }()
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.theme.separator
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        contentView.addSubview(stackView)
        contentView.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configure(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
