//
//  MemoryGame.swift
//  Memorize
//
//  Created by Bogna Knychala on 18/07/2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    private(set) var score: Int = 0
    
    private var alreadySeenCardIds = Set<Int>()
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                let potentialMatchCard = cards[potentialMatchIndex]
                if cards[chosenIndex].content == potentialMatchCard.content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score = score + 2
                } else {
                    if (alreadySeenCardIds.contains(card.id)) {
                        score = score - 1
                    } else {
                        alreadySeenCardIds.insert(card.id)
                    }
                    
                    if (alreadySeenCardIds.contains(potentialMatchCard.id)) {
                        score = score - 1
                    } else {
                        alreadySeenCardIds.insert(potentialMatchCard.id)
                    }
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false;
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle();
        } else {
            print("Invalid card, ignoring")
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
