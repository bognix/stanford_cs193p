//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Bogna Knychala on 6/22/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
