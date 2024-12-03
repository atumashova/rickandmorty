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
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: self.view.frame.width - 44, height: 357)
        layout.minimumLineSpacing = 55
        layout.sectionInset = UIEdgeInsets(top: 30, left: 22, bottom: 0, right: 22)
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(EpisodeCell.self, forCellWithReuseIdentifier: EpisodeCell.reuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        makeDataSouce()
        updateDataSource([EpisodeModel(id: 0, name: "Episode", episode: "vsdvd", characters: ["character1"]), EpisodeModel(id: 1, name: "Episode 1", episode: "vsdd", characters: ["character2"])])
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
    }
    private func updateDataSource(_ data: [EpisodeModel]) {
        var snapshot = EpisodeSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(data)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
