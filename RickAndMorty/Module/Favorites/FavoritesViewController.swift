//
//  FavoritesViewController.swift
//  RickAndMorty
//
//  Created by Anna on 23.11.2024.
//

import Foundation
import UIKit

final class FavoritesViewController: UIViewController {
    enum Event {
        case detailCharacter(String)
    }
    var didSendEventHandler: ((Event) -> Void)?
    private typealias EpisodeDataSource = UICollectionViewDiffableDataSource<Section, EpisodeModel>
    private typealias EpisodeSnapshot = NSDiffableDataSourceSnapshot<Section, EpisodeModel>
    private var dataSource: EpisodeDataSource?
    private lazy var episodesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectionViewLayout)
        collectionView.register(EpisodeCell.self, forCellWithReuseIdentifier: EpisodeCell.reuseIdentifier)
        return collectionView
    }()
    lazy var collectionViewLayout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(357))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 55
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 22, bottom: 20, trailing: 22)
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(316))
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    var viewModel: FavoritesViewModelDelegate? {
        didSet {
            viewModel?.updateFavoritesEpisodesHandler = { [weak self] episodes in
                self?.updateDataSource(episodes)
            }
            viewModel?.updateCharacterHandler = { [weak self] (episodeIndex, character) in
                guard let cell = self?.episodesCollectionView.cellForItem(at: IndexPath(row: episodeIndex, section: 0)) as? EpisodeCell else {
                    return
                }
                cell.configure(character: character)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.navigationItem.title = Constants.favoriteEpisodesTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateInfo()
    }
    
    private func updateInfo() {
        viewModel?.getFavoriteEpisodes()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        makeDataSouce()
        view.addSubview(episodesCollectionView)
        episodesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episodesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            episodesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            episodesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            episodesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        episodesCollectionView.delegate = self
        episodesCollectionView.dataSource = dataSource
    }
}
// MARK: - UICollectionViewDelegate
extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let episode = viewModel?.getDetailEpisode(index: indexPath.row)
        guard let character = episode?.character else {return}
        didSendEventHandler?(.detailCharacter(character))
    }
}
// MARK: - UITableViewDataSource
private extension FavoritesViewController {
    private enum Section {
        case main
    }
    private func makeDataSouce() {
        dataSource = EpisodeDataSource(collectionView: episodesCollectionView, cellProvider: { collectionView, indexPath, episode in
            guard let cell = self.episodesCollectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCell.reuseIdentifier, for: indexPath) as? EpisodeCell
            else { return UICollectionViewCell() }
            cell.delegate = self
            cell.configure(episode: episode, isFavorite: self.viewModel?.isFavoriteEpisode(episode) ?? false)
            self.viewModel?.getCharacter(episode: episode)
            return cell
        })
    }
    private func updateDataSource(_ data: [EpisodeModel]) {
        var snapshot = EpisodeSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(data)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
// MARK: - Episode cell
extension FavoritesViewController: EpisodeCellDelegate {
    func updateFavorite(isSelected: Bool, episode: EpisodeModel) {
        viewModel?.changeEpisodeFavorite(episode: episode, isFavorite: isSelected)
    }
}
