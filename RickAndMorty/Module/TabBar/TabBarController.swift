//
//  TabBarViewController.swift
//  RickAndMorty
//
//  Created by Anna on 23.11.2024.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    init(controllers: [UIViewController]) {
        self.controllers = controllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var controllers: [UIViewController]
    var startIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(controllers: controllers)
        setupUI()
    }
    private func setupUI() {
    }
    
    private func configure(controllers: [UIViewController]) {
        self.controllers = controllers
        viewControllers = controllers
    }
}
