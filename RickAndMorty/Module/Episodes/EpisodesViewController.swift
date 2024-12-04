//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Anna on 23.11.2024.
//

import Foundation
import UIKit

final class EpisodesViewController: UIViewController {
    private typealias EpisodeDataSource = UICollectionViewDiffableDataSource<Section, EpisodeModel>
    private typealias EpisodeSnapshot = NSDiffableDataSourceSnapshot<Section, EpisodeModel>
    private var dataSource: EpisodeDataSource?
    private lazy var episodesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectionViewLayout)
        collectionView.register(EpisodeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EpisodeHeaderView.reuseIdentifier)
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
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind:  UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    var viewModel: EpisodesViewModelDelegate? {
        didSet {
            viewModel?.updateEpisodesHandler = { [weak self] episodes in
                self?.updateDataSource(episodes)
                self?.episodesCollectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel?.getEpisodes()
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
        episodesCollectionView.dataSource = dataSource
    }
}
// MARK: - UITableViewDataSource
private extension EpisodesViewController {
    private enum Section {
        case main
    }
    private func makeDataSouce() {
        dataSource = EpisodeDataSource(collectionView: episodesCollectionView, cellProvider: { collectionView, indexPath, episode in
            guard let cell = self.episodesCollectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCell.reuseIdentifier, for: indexPath) as? EpisodeCell
            else { return UICollectionViewCell() }
            cell.configure(episode: episode)
            return cell
        })
        dataSource?.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            guard let header =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EpisodeHeaderView.reuseIdentifier, for: indexPath) as? EpisodeHeaderView else {
                return nil
            }
            return header
        }
    }
    private func updateDataSource(_ data: [EpisodeModel]) {
        var snapshot = EpisodeSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(data)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
