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
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
    }
}
