//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Bogna Knychala on 18/07/2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    private var gameTheme: GameTheme
    
    static func selectTheme() -> GameTheme {
        if let selectedTheme = GameTheme.Themes.allCases.randomElement() {
            return GameTheme(selectedTheme)
        } else {
            return GameTheme(GameTheme.Themes.Animals)
        }
    }
    
    static func createMemoryGame(theme: GameTheme) -> MemoryGame<String> {
        let shuffledEmojis = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.pairsPerGame) { index in shuffledEmojis[index] }
    }

    init() {
        let selectedTheme = EmojiMemoryGame.selectTheme()
        model = EmojiMemoryGame.createMemoryGame(theme: selectedTheme)
        gameTheme = selectedTheme
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var themeName: String {
        switch  gameTheme.type {
        case GameTheme.Themes.Animals:
            return "Animals!"
        case GameTheme.Themes.Vehicles:
            return "Vehicles"
        case GameTheme.Themes.Halloween:
            return "Halloween"
        case GameTheme.Themes.Reactions:
            return "Reactions!"
        default:
            return "Standard theme"
        }
    }
    
    var themeColor: Color {
        switch  gameTheme.type {
        case GameTheme.Themes.Animals:
            return .green
        case GameTheme.Themes.Vehicles:
            return .gray
        case GameTheme.Themes.Halloween:
            return .orange
        case GameTheme.Themes.Reactions:
            return .red
        default:
            return .blue
        }
    }
    
    // MARK: - Intent(s)
    
    func newGame() {
        gameTheme = EmojiMemoryGame.selectTheme()
        model = EmojiMemoryGame.createMemoryGame(theme: gameTheme)
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
