//
//  EpisodeFilterView.swift
//  RickAndMorty
//
//  Created by Anna on 03.12.2024.
//

import Foundation
import UIKit

class EpisodeFilterView: UIView {
    
    private lazy var filterImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Images.filterIcon))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.filterTitle
        label.font = UIFont.theme.filter
        label.textColor = UIColor.theme.blueText
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = UIColor.theme.blueBackground
        addSubview(filterImageView)
        addSubview(filterLabel)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        filterImageView.translatesAutoresizingMaskIntoConstraints = false
        applyShadow()
        NSLayoutConstraint.activate([
            filterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            filterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            filterLabel.topAnchor.constraint(equalTo: self.topAnchor),
            filterLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            filterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            filterImageView.topAnchor.constraint(equalTo: self.topAnchor),
            filterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func applyShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.24
        layer.masksToBounds = false
    }
}
