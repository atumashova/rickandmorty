//
//  EpisodeHeader.swift
//  RickAndMorty
//
//  Created by Anna on 01.12.2024.
//

import Foundation
import UIKit

protocol EpisodeHeaderDelegate {
    func changeSearchTextField(text: String?)
}

class EpisodeHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "EpisodeHeaderView"
    var delegate: EpisodeHeaderDelegate?
    var search: String? {
        didSet {
            searchField.text = search
            if let search = search {
                DispatchQueue.main.async {
                    self.searchField.becomeFirstResponder()
                }
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Images.logo)
        return imageView
    }()
    
    private lazy var searchField: UISearchTextField = {
        let searchField = UISearchTextField()
        searchField.placeholder = Constants.searchEpisodePlaceholder
        searchField.borderStyle = .none
        searchField.backgroundColor = .clear
        searchField.layer.borderWidth = 1
        searchField.layer.cornerRadius = 8
        searchField.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        return searchField
    }()
    
    private lazy var filterButton: EpisodeFilterView = {
        let view = EpisodeFilterView()
        return view
    }()
    
    private func setupUI() {
        searchField.addTarget(self, action: #selector(searchTextFildValueChanged), for: .editingChanged)
        let stackView = UIStackView(arrangedSubviews: [logoImageView, searchField, filterButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterButton.heightAnchor.constraint(equalToConstant: 56),
            searchField.heightAnchor.constraint(equalToConstant: 56),
            logoImageView.heightAnchor.constraint(equalToConstant: 125),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    @objc func searchTextFildValueChanged(textField: UITextField) {
        delegate?.changeSearchTextField(text: textField.text)
    }
}
