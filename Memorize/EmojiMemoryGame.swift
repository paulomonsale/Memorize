//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Paulo Monsale on 9/24/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    let sportsEmojis = ["⚽️","🏀","🎾","⚾️","🏈","🏊‍♀️","🏌️‍♂️","🏐","🚴‍♂️","🏄‍♀️","🏃‍♂️","🤺"
                        ,"⚽️","🏀","🎾","⚾️","🏈","🏊‍♀️","🏌️‍♂️","🏐","🚴‍♂️","🏄‍♀️","🏃‍♂️","🤺"]
    let atlaEmojis = ["💧","🪨","🔥","💨","🪭","🪃","🌵","🐉","🍵","⚡️","🗺️","🩸","🪷"
                      ,"💧","🪨","🔥","💨","🪭","🪃","🌵","🐉","🍵","⚡️","🗺️","🩸","🪷"]
    let foodEmojis = ["🍣","🍕","🌮","🥟","🍔","🥭","🥞","🍜","🍿","🍨","🧋"
                      ,"🍣","🍕","🌮","🥟","🍔","🥭","🥞","🍜","🍿","🍨","🧋"]

    private static var emojis = [""]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
        
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func changeTheme(_ theme: String) {
        switch theme {
        case "sports":
//            emojis = sportsEmojis
            break
        case "atla":
//            emojis = atlaEmojis
            break
        case "food":
//            emojis = foodEmojis
            break
        default: break
        }
    }
}
