//
//  ContentView.swift
//  HotProspects
//
//  Created by Ihor Sukhachov on 08.01.2026.
//


import SwiftUI


struct ContentView: View {
    
    var body: some View {
        
        TabView {
            ProspectsView()
                .tabItem {
                        Label("Everyone", systemImage: "person.3")
                }
            ProspectsView()
                .tabItem {
                        Label("Everyone", systemImage: "person.3")
                }
            ProspectsView()
                .tabItem {
                        Label("Everyone", systemImage: "person.3")
                }
        }
        
    }
}

#Preview {
    ContentView()
}
