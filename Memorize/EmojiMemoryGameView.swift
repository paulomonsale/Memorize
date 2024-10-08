//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Paulo Monsale on 9/19/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    
    @ObservedObject var manager: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
        
    var body: some View {
        VStack {
            Text(EmojiMemoryGame.themeName).font(.title)
            cards
                .foregroundColor(EmojiMemoryGame.cardColor)
            HStack {
                score
                Spacer()
                newGame
            }
            .font(.title)
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(manager.score)").font(.title)
            .animation(nil)
    }
    
    private var newGame: some View {
        Button("New Game") {
            withAnimation {
                manager.startNewGame()
            }
        }
    }
    
    
    private var cards: some View {
        AspectVGrid(manager.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    choose(card)
                }
        }
    }
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = manager.score
            manager.choose(card)
            let scoreChange = manager.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}

#Preview {
    EmojiMemoryGameView(manager: EmojiMemoryGame())
}
