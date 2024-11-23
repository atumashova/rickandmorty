//
//  LaunchViewController.swift
//  RickAndMorty
//
//  Created by Anna on 22.11.2024.
//

import Foundation
import UIKit

final class LaunchViewController: UIViewController {
    
    private lazy var animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 1, curve: .easeInOut)
    }()
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImage(named: Images.logo)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var loadingImageView: UIImageView = {
        let image = UIImage(named: Images.loadingElement)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showAnimation()
    }
    private func setupUI() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        view.addSubview(loadingImageView)
        loadingImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            loadingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60)
        ])
    }
    func showAnimation() {
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 1
        scale.toValue = 0.65
        scale.autoreverses = true
        scale.isRemovedOnCompletion = false
        scale.repeatCount = .infinity
        scale.speed = 3
        scale.duration = 2 * CGFloat.pi
        loadingImageView.layer.add(scale, forKey: "transform.scale")
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = 0
        rotate.toValue = 2 * CGFloat.pi
        rotate.isRemovedOnCompletion = false
        rotate.repeatCount = .infinity
        rotate.speed = 3
        rotate.duration = 2 * CGFloat.pi
        loadingImageView.layer.add(rotate, forKey: "transform.rotation")
    }
}
