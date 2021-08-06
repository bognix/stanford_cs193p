//
//  GameTheme.swift
//  Memorize
//
//  Created by Bogna Knychala on 28/07/2021.
//

import Foundation

struct GameTheme {
    var emojis: Array<String>
    var type: Themes
    var pairsPerGame: Int
    
    enum Themes: CaseIterable {
        case Halloween
        case Animals
        case Vehicles
        case Reactions
    }
    
    init(_ theme: Themes) {
        switch theme {
        case .Halloween:
            type = .Halloween
            emojis = ["🎃", "👻", "💀", "😱", "🍬"]
            pairsPerGame = 3
        case .Animals:
            type = .Animals
            emojis = ["🐶", "🐈", "🕊", "🐢", "🐟", "🐕‍🦺", "🐷", "🦝", "🙈", "🙊", "🐑", "🐯", "🐌"]
            pairsPerGame = 5
        case .Reactions:
            type = .Reactions
            emojis = ["😊", "😁", "🤣", "😍", "🤩", "😛"]
            pairsPerGame = 4
        case .Vehicles:
            type = .Vehicles
            emojis = ["✈️", "🚗", "🚘", "🚝", "🛵", "🚜", "🚔", "🏎"]
            pairsPerGame = 6
        }
    }
}
