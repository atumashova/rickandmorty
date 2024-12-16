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
    let separator = UIColor(named: "Separator") ?? UIColor.lightGray
    let characterText = UIColor(named: "CharacterText") ?? UIColor.gray
    let characterInfo = UIColor(named: "CharacterInfo") ?? UIColor.gray
    let characterBorder = UIColor(named: "CharacterBorder") ?? UIColor.gray
    let characterDarkText = UIColor(named: "CharacterDarkText") ?? UIColor.black
    let black = UIColor.black
}

struct FontTheme {
    let characterName = UIFont(name: "Roboto-Regular", size: 32) ?? UIFont.systemFont(ofSize: 32)
    let characterInfoTitle = UIFont(name: "Roboto-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
    let characterInfoDescription = UIFont(name: "Roboto-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
    let filter = UIFont(name: "Roboto-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .medium)
    let episode = UIFont(name: "Roboto-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
    let character = UIFont(name: "Roboto-Medium", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .medium)
    let navigationTitle = UIFont(name: "Roboto-Medium", size: 24) ?? UIFont.systemFont(ofSize: 24, weight: .medium)
}
