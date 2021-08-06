//
//  ContentView.swift
//  Memorize
//
//  Created by Bogna Knychala on 6/22/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    // this variable always reflects the state of the Model. The only way to write on the screen.
    var body: some View {
        ScrollView {
            Text(viewModel.themeName)
            
            Text("Your score: \(viewModel.score)")
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
    //                each element in array has to be identifiable in order to use it in the ForEach. We used small hack with \.self
                ForEach(viewModel.cards) { card in
                    CardView(card: card, themeColor: viewModel.themeColor)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            
            Button(action: {
                viewModel.newGame()
            }, label: {
                Text("New Game")
            })
        }
        .font(.largeTitle)
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    let themeColor: Color
    
    var body: some View {
//        ZStack accepts the content argument which is a function. We can skip the name of the argument
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill().foregroundColor(themeColor)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
