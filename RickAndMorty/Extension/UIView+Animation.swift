//
//  UIView+Animation.swift
//  RickAndMorty
//
//  Created by Ann on 09.01.2025.
//

import UIKit

extension UIView {
    func zoomIn(duration: TimeInterval = 0.5, completed: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseIn], animations: { () in
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { (_: Bool) in
            self.transform = CGAffineTransform.identity
            completed?()
        })
    }
}
