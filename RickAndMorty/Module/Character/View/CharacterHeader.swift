//
//  CharacterHeader.swift
//  RickAndMorty
//
//  Created by Ann on 15.12.2024.
//

import Foundation
import UIKit

final class CharacterHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = "CharacterHeader"
    private lazy var avatarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 74
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.theme.characterBorder.cgColor
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Rick Sanchez"
        label.font = UIFont.theme.characterName
        label.textColor = UIColor.theme.characterDarkText
        label.textAlignment = .center
        return label
    }()
    private lazy var cameraBtn: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
        button.setImage(UIImage(named: Images.characterCameraIcon), for: .normal)
        return button
    }()
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.infoCharacterTitle
        label.font = UIFont.theme.character
        label.textColor = UIColor.theme.characterInfo
        label.textAlignment = .left
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: CharacterModel) {
        nameLabel.text = model.name
        avatarImageView.downloaded(from: model.image, contentMode: .scaleAspectFill)
    }
    
    private func setupUI() {
        avatarView.addSubview(cameraBtn)
        avatarView.addSubview(avatarImageView)
        cameraBtn.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 148),
            avatarImageView.widthAnchor.constraint(equalToConstant: 148),
            cameraBtn.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            cameraBtn.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            cameraBtn.heightAnchor.constraint(equalToConstant: 50),
            cameraBtn.widthAnchor.constraint(equalToConstant: 50)
        ])
        let stackView = UIStackView(arrangedSubviews: [avatarView, nameLabel, infoLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        contentView.addSubview(stackView)
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarView.heightAnchor.constraint(equalToConstant: 188),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
        ])
    }
}
