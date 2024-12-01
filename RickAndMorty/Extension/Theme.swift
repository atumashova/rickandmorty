//
//  Theme.swift
//  RickAndMorty
//
//  Created by Anna on 30.11.2024.
//

import Foundation
import UIKit

extension UIColor {
    static let theme = ColorTheme()
}
extension UIFont {
    static let theme = FontTheme()
}

struct ColorTheme {
    let secondBackground = UIColor(named: "SecondBackground")!
}

struct FontTheme {
    let episode = UIFont(name: "Roboto-Regular", size: 16)
    let character = UIFont(name: "Roboto-Medium", size: 20)
}
