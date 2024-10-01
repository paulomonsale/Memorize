//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Paulo Monsale on 9/24/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let sportsEmojis = ["⚽️","🏀","🎾","⚾️","🏈","🏊‍♀️","🏌️‍♂️","🏐","🚴‍♂️","🏄‍♀️","🏃‍♂️","🤺","⚽️","🏀","🎾","⚾️","🏈","🏊‍♀️","🏌️‍♂️","🏐","🚴‍♂️","🏄‍♀️","🏃‍♂️","🤺"]
    static let atlaEmojis = ["💧","🪨","🔥","💨","🪭","🪃","🌵","🐉","🍵","⚡️","🗺️","🩸","🪷","💧","🪨","🔥","💨","🪭","🪃","🌵","🐉","🍵","⚡️","🗺️","🩸","🪷"]
    static let foodEmojis = ["🍣","🍕","🌮","🥟","🍔","🥭","🥞","🍜","🍿","🍨","🧋"
        ,"🍣","🍕","🌮","🥟","🍔","🥭","🥞","🍜","🍿","🍨","🧋"]

    private static func createMemoryGame(themeNum: Int) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 12) { pairIndex in
            var emojis = [""]
            switch themeNum {
            case 1: emojis = sportsEmojis
            case 2: emojis = atlaEmojis
            case 3: emojis = foodEmojis
            default: break
            }
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
        
    @Published private var model = createMemoryGame(themeNum: Int.random(in: 1...3))
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func startNewGame() {
        model = EmojiMemoryGame.createMemoryGame(themeNum: Int.random(in: 1...3))
    }
        
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
