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
        
    var body: some View {
        VStack {
            Text(EmojiMemoryGame.themeName).font(.title)
            cards
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
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(EmojiMemoryGame.cardColor)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
