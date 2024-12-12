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
    let secondBackground = UIColor(named: "SecondBackground") ?? UIColor.gray
    let blueBackground = UIColor(named: "BlueBackground") ?? UIColor.blue
    let blueText = UIColor(named: "BlueText") ?? UIColor.blue
}

struct FontTheme {
    let filter = UIFont(name: "Roboto-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .medium)
    let episode = UIFont(name: "Roboto-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
    let character = UIFont(name: "Roboto-Medium", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .medium)
}
