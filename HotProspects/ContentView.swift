//
//  ContentView.swift
//  HotProspects
//
//  Created by Ihor Sukhachov on 08.01.2026.
//

import SwiftUI

struct ContentView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Sora"]
    
    var body: some View {
        VStack {
            List(users, id: \.self) {user in
                Text(user)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
