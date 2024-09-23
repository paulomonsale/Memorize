//
//  ContentView.swift
//  Memorize
//
//  Created by Paulo Monsale on 9/19/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"]
    
    @State var cardCount: Int = 4
    
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var themes: some View {
        HStack {
            theme1
            Spacer()
            theme2
            Spacer()
            theme3
        }
        .imageScale(.large)
        .font(.title3)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    func themeChooser(symbol: String, name: String) -> some View {
        VStack {
            Button(action: {
                
            }, label: {
                Image(systemName: symbol)
            })
            Text(name).font(.footnote)
        }
    }
    
    var theme1: some View {
        themeChooser(symbol: "figure.run", name: "Sports")
    }
    
    var theme2: some View {
        themeChooser(symbol: "wind", name: "ATLA")
    }
    
    var theme3: some View {
        themeChooser(symbol: "fork.knife", name: "Food")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
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
