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
    let blueBackground = UIColor(named: "BlueBackground")!
    let blueText = UIColor(named: "BlueText")!
}

struct FontTheme {
    let filter = UIFont(name: "Roboto-Medium", size: 14)!
    let episode = UIFont(name: "Roboto-Regular", size: 16)
    let character = UIFont(name: "Roboto-Medium", size: 20)
}
