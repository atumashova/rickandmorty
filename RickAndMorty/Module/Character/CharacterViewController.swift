//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Ann on 15.12.2024.
//

import Foundation
import UIKit

final class CharacterViewController: UIViewController {
    private typealias CharacterDataSource = UITableViewDiffableDataSource<Section, String>
    private typealias CharacterSnapshot = NSDiffableDataSourceSnapshot<Section, String>
    private var dataSource: CharacterDataSource?
    private lazy var characterTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(CharacterInfoCell.self, forCellReuseIdentifier: CharacterInfoCell.reuseIdentifier)
        tableView.register(CharacterHeader.self, forHeaderFooterViewReuseIdentifier: CharacterHeader.reuseIdentifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateInfo()
    }
    
    private func updateInfo() {
        updateDataSource(["gtregtrgt", "Btrbtrb", "btrbtrbtr", "btbtrbrtb"])
    }
    
    private func setupUI() {
        navigationItem.backButtonTitle = Constants.navigationBackBtn
        let leftItem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: Images.characterBarIcon)))
        navigationItem.setRightBarButton(leftItem, animated: false)
        view.backgroundColor = .white
        makeDataSouce()
        view.addSubview(characterTableView)
        characterTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterTableView.topAnchor.constraint(equalTo: view.topAnchor),
            characterTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            characterTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        characterTableView.delegate = self
        characterTableView.dataSource = dataSource
    }
}
// MARK: - UITableViewDataSource
extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        250
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CharacterHeader.reuseIdentifier) as? CharacterHeader {
            return header
        } else {
            return nil
        }
    }
}
// MARK: - UITableViewDataSource
private extension CharacterViewController {
    private enum Section {
        case main
    }
    private func makeDataSouce() {
        dataSource = CharacterDataSource(tableView: characterTableView, cellProvider: {
            tableView, indexPath, str in
            guard let cell = self.characterTableView.dequeueReusableCell(withIdentifier: CharacterInfoCell.reuseIdentifier, for: indexPath) as? CharacterInfoCell
            else { return nil }
            cell.configure(title: "Title", description: str)
            return cell
        })
    }
    private func updateDataSource(_ data: [String]) {
        var snapshot = CharacterSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(data)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
