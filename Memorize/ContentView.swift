//
//  ContentView.swift
//  Memorize
//
//  Created by Paulo Monsale on 9/19/24.
//

import SwiftUI

struct ContentView: View {
    let sportsEmojis = ["⚽️","🏀","🎾","⚾️","🏈","🏊‍♀️","🏌️‍♂️","🏐","🚴‍♂️","🏄‍♀️","🏃‍♂️","🤺"
        ,"⚽️","🏀","🎾","⚾️","🏈","🏊‍♀️","🏌️‍♂️","🏐","🚴‍♂️","🏄‍♀️","🏃‍♂️","🤺"]
    let atlaEmojis = ["💧","🪨","🔥","💨","🪭","🪃","🌵","🐉","🍵","⚡️","🗺️","🩸","🪷","💧","🪨","🔥","💨","🪭","🪃","🌵","🐉","🍵","⚡️","🗺️","🩸","🪷"]
    let foodEmojis =
        ["🍣","🍕","🌮","🥟","🍔","🥭","🥞","🍜","🍿","🍨","🧋"
        ,"🍣","🍕","🌮","🥟","🍔","🥭","🥞","🍜","🍿","🍨","🧋"]
    @State var emojis: Array<String> = []
        
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themes
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65), spacing: 4)], spacing: 4) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fill)
            }
        }
        .foregroundColor(.blue)
    }
    
    var themes: some View {
        HStack(spacing: 80) {
            theme1
            theme2
            theme3
        }
        .imageScale(.large)
        .font(.title2)
    }
    
    func themeChooser(cardSet: [String], symbol: String, name: String) -> some View {
        VStack {
            Button(action: {
                emojis = cardSet.shuffled()
            }, label: {
                Image(systemName: symbol)
            })
            Text(name).font(.footnote)
        }
    }
    
    var theme1: some View {
        themeChooser(cardSet: sportsEmojis, symbol: "figure.run", name: "Sports")
    }
    
    var theme2: some View {
        themeChooser(cardSet: atlaEmojis, symbol: "wind", name: "ATLA")
    }
    
    var theme3: some View {
        themeChooser(cardSet: foodEmojis, symbol: "fork.knife", name: "Food")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)

        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
