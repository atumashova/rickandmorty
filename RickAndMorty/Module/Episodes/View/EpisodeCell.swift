//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by Anna on 28.11.2024.
//

import Foundation
import UIKit

final class EpisodeCell: UICollectionViewCell {
    static let reuseIdentifier = "EpisodeCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.cornerRadius = 4
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var episodeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = UIColor.theme.secondBackground
        return view
    }()
    
    private lazy var characterView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    private lazy var episodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: Images.episodeIcon)
        return imageView
    }()
    
    private lazy var episodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.theme.episode
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var characterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.theme.character
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Images.favoriteIcon), for: .normal)
        button.setImage(UIImage(named: Images.favoriteSelectedIcon), for: .selected)
        return button
    }()
    
    func configure(episode: EpisodeModel) {
        episodeLabel.text = "\(episode.name) | \(episode.episode)"
    }
    func configure(character: CharacterModel) {
        characterLabel.text = character.name
        characterImageView.downloaded(from: character.image, contentMode: .scaleAspectFill)
    }
    
    @objc func tapFavoriteButton(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    private func setupUI() {
        favoriteButton.addTarget(self, action: #selector(tapFavoriteButton), for: .touchUpInside)
        contentView.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [characterImageView, characterView, episodeView])
        characterView.addSubview(characterLabel)
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterLabel.topAnchor.constraint(equalTo: characterView.topAnchor),
            characterLabel.bottomAnchor.constraint(equalTo: characterView.bottomAnchor),
            characterLabel.leadingAnchor.constraint(equalTo: characterView.leadingAnchor, constant: 20),
            characterLabel.trailingAnchor.constraint(equalTo: characterView.trailingAnchor)
        ])
        stackView.frame = backView.frame
        stackView.axis = .vertical
        backView.addSubview(stackView)
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episodeView.heightAnchor.constraint(equalToConstant: 71),
            characterImageView.heightAnchor.constraint(equalToConstant: 232)
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        let stackEpisodeView = UIStackView(arrangedSubviews: [episodeImageView, episodeLabel, favoriteButton])
        stackEpisodeView.axis = .horizontal
        stackEpisodeView.spacing = 10
        episodeView.addSubview(stackEpisodeView)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        stackEpisodeView.translatesAutoresizingMaskIntoConstraints = false
        episodeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            episodeImageView.widthAnchor.constraint(equalToConstant: 33),
            stackEpisodeView.topAnchor.constraint(equalTo: episodeView.topAnchor),
            stackEpisodeView.bottomAnchor.constraint(equalTo: episodeView.bottomAnchor),
            stackEpisodeView.leadingAnchor.constraint(equalTo: episodeView.leadingAnchor, constant: 20),
            stackEpisodeView.trailingAnchor.constraint(equalTo: episodeView.trailingAnchor, constant: -20)
        ])
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        episodeLabel.text = nil
        characterLabel.text = nil
        characterImageView.image = nil
    }
}
