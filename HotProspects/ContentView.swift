//
//  ContentView.swift
//  HotProspects
//
//  Created by Ihor Sukhachov on 08.01.2026.
//

import SwiftUI

struct ContentView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Sora"]
    @State private var selection: String?
    
    var body: some View {
        VStack {
            List(users, id: \.self, selection: $selection) {user in
                Text(user)
            }
            
            if let selection {
                Text("You selected \(selection)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
