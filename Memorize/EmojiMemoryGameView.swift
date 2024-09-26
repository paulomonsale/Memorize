//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Paulo Monsale on 9/19/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
//    let sportsEmojis = ["⚽️","🏀","🎾","⚾️","🏈","🏊‍♀️","🏌️‍♂️","🏐","🚴‍♂️","🏄‍♀️","🏃‍♂️","🤺"
//                        ,"⚽️","🏀","🎾","⚾️","🏈","🏊‍♀️","🏌️‍♂️","🏐","🚴‍♂️","🏄‍♀️","🏃‍♂️","🤺"]
//    let atlaEmojis = ["💧","🪨","🔥","💨","🪭","🪃","🌵","🐉","🍵","⚡️","🗺️","🩸","🪷"
//                      ,"💧","🪨","🔥","💨","🪭","🪃","🌵","🐉","🍵","⚡️","🗺️","🩸","🪷"]
//    let foodEmojis =
//        ["🍣","🍕","🌮","🥟","🍔","🥭","🥞","🍜","🍿","🍨","🧋"
//         ,"🍣","🍕","🌮","🥟","🍔","🥭","🥞","🍜","🍿","🍨","🧋"]
    @State var cardColor: Color = .black
        
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            Button("Shuffle") {
                viewModel.shuffle()
            }
            Spacer()
            themes
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fill)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(cardColor)
    }
    
    var themes: some View {
        HStack(alignment: .lastTextBaseline, spacing: 80) {
            theme1
            theme2
            theme3
        }
        .imageScale(.large)
        .font(.title2)
    }
    
    func themeChooser(_ theme: String, symbol: String, name: String, color: Color) -> some View {
        VStack() {
            Button(action: {
                viewModel.changeTheme(_: theme)
                viewModel.shuffle()
                cardColor = color
            }, label: {
                Image(systemName: symbol)
            })
            Text(name).font(.footnote)
        }
    }
    
    var theme1: some View {
        themeChooser(_: "sports", symbol: "figure.run", name: "Sports", color: .green)
    }
    
    var theme2: some View {
        themeChooser(_: "atla", symbol: "wind", name: "ATLA", color: .cyan)
    }
    
    var theme3: some View {
        themeChooser(_: "food", symbol: "fork.knife", name: "Food", color: .red)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
