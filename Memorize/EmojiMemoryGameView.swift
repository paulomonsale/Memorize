//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Paulo Monsale on 9/19/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
        
    var body: some View {
        VStack {
            Text(EmojiMemoryGame.themeName).font(.title)
            cards
                .foregroundColor(EmojiMemoryGame.cardColor)
                .animation(.default, value: viewModel.cards)
            Spacer()
            HStack {
                Text("Score: \(viewModel.score)").font(.title)
                Spacer()
                Button("New Game") {
                    viewModel.startNewGame()
                }
                .font(.title)
            }
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
