//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Paulo Monsale on 9/24/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    static let sportEmojis = ["⚽️","🏀","🎾","⚾️","🏈","🏊‍♀️","🏌️‍♂️","🏐","🚴‍♂️","🏄‍♀️","🏃‍♂️","🤺","🏒","🚣‍♂️","🤽‍♀️"]
    static let atlaEmojis = ["💧","🪨","🔥","💨","🪭","🪃","🌵","🐉","🍵","⚡️","🗺️","🩸","🪷","☄️","⛰️"]
    static let foodEmojis = ["🍣","🍕","🌮","🥟","🍔","🥭","🥞","🍜","🍿","🍨","🧋"
        ,"🍌","🥗","🥧","🥙"]
    static let halloweenEmojis = ["👻","🎃","💀","👹","🐈‍⬛","🪦","🦇","🧛‍♂️","😱","🌖","🧙‍♀️","🧟","🍬","🕷️","🕯️"]
    static let animalEmojis = ["🐢","🦓","🐋","🐘","🦦","🦜","🐊","🐅","🐃","🦚","🦀","🪼","🦋","🦌","🦒"]
    static let techEmojis = ["📱","🛰️","🔭","📜","⛵️","💡","🚂","🧭","🛫","💻","🎥","🔋","🛜","📺","👓"]
    static var cardColor: Color = .black
    static var themeName: String = ""
    
    private static func createMemoryGame(themeNum: Int) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 2) { pairIndex in
            var emojis = [""]
            switch themeNum {
            case 1:
                themeName = "Sports"
                emojis = sportEmojis
                cardColor = .red
            case 2:
                themeName = "Avatar: The Last Airbender"
                emojis = atlaEmojis
                cardColor = .orange
            case 3:
                themeName = "Food"
                emojis = foodEmojis
                cardColor = .yellow
            case 4:
                themeName = "Halloween"
                emojis = halloweenEmojis
                cardColor = .purple
            case 5:
                themeName = "Animals"
                emojis = animalEmojis
                cardColor = .green
            case 6:
                themeName = "Technology"
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
    
    var cards: Array<Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intents
    
    func startNewGame() {
        model = EmojiMemoryGame.createMemoryGame(themeNum: Int.random(in: 1...6))
    }
        
    func choose(_ card: Card) {
        model.choose(card)
    }
}
