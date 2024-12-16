//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Ann on 15.12.2024.
//

import Foundation
import UIKit

final class CharacterViewController: UIViewController {
    private typealias CharacterDataSource = UITableViewDiffableDataSource<Section, CharacterInfo>
    private typealias CharacterSnapshot = NSDiffableDataSourceSnapshot<Section, CharacterInfo>
    private var dataSource: CharacterDataSource?
    private lazy var characterTableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: .grouped)
        tableView.allowsSelection = false
        tableView.backgroundColor = .white
        tableView.register(CharacterInfoCell.self, forCellReuseIdentifier: CharacterInfoCell.reuseIdentifier)
        tableView.register(CharacterHeader.self, forHeaderFooterViewReuseIdentifier: CharacterHeader.reuseIdentifier)
        return tableView
    }()
    var viewModel: CharacterViewModelDelegate? {
        didSet {
            viewModel?.updateCharacterHandler = { [weak self] character in
                self?.updateInfo(character: character)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setCharacter(_ str: String) {
        viewModel?.getCharacter(character: str)
    }
    
    private func updateInfo(character: CharacterModel) {
        updateDataSource(character.info)
        if let header = characterTableView.headerView(forSection: 0) as? CharacterHeader {
            header.configure(model: character)
        }
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
        320
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
            tableView, indexPath, info in
            guard let cell = self.characterTableView.dequeueReusableCell(withIdentifier: CharacterInfoCell.reuseIdentifier, for: indexPath) as? CharacterInfoCell
            else { return nil }
            cell.configure(title: info.name, description: info.value)
            return cell
        })
    }
    private func updateDataSource(_ data: [CharacterInfo]) {
        var snapshot = CharacterSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(data)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
