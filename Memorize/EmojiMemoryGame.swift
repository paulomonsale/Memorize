//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Paulo Monsale on 9/24/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let sportEmojis = ["⚽️","🏀","🎾","⚾️","🏈","🏊‍♀️","🏌️‍♂️","🏐","🚴‍♂️","🏄‍♀️","🏃‍♂️","🤺","🏒","🚣‍♂️","🤽‍♀️"]
    static let atlaEmojis = ["💧","🪨","🔥","💨","🪭","🪃","🌵","🐉","🍵","⚡️","🗺️","🩸","🪷","☄️","⛰️"]
    static let foodEmojis = ["🍣","🍕","🌮","🥟","🍔","🥭","🥞","🍜","🍿","🍨","🧋"
        ,"🍌","🥗","🥧","🥙"]
    static let halloweenEmojis = ["👻","🎃","💀","👹","🐈‍⬛","🪦","🦇","🧛‍♂️","😱","🌖","🧙‍♀️","🧟","🍬","🕷️","🕯️"]
    static let animalEmojis = ["🐢","🦓","🐋","🐘","🦦","🦜","🐊","🐅","🐃","🦚","🦀","🪼","🦋","🦌","🦒"]
    static let techEmojis = ["📱","🛰️","🔭","📜","⛵️","💡","🚂","🧭","🛫","💻","🎥","🔋","🛜","📺","👓"]
    static var cardColor: Color = .black
    
    private static func createMemoryGame(themeNum: Int) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 15) { pairIndex in
            var emojis = [""]
            switch themeNum {
            case 1:
                emojis = sportEmojis
                cardColor = .red
            case 2:
                emojis = atlaEmojis
                cardColor = .orange
            case 3:
                emojis = foodEmojis
                cardColor = .yellow
            case 4:
                emojis = halloweenEmojis
                cardColor = .purple
            case 5:
                emojis = animalEmojis
                cardColor = .green
            case 6:
                emojis = techEmojis
                cardColor = .blue
            default: break
            }
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
        
    @Published private var model = createMemoryGame(themeNum: Int.random(in: 1...6))
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func startNewGame() {
        model = EmojiMemoryGame.createMemoryGame(themeNum: Int.random(in: 1...6))
    }
        
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
