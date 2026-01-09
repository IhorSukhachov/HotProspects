//
//  ContentView.swift
//  HotProspects
//
//  Created by Ihor Sukhachov on 08.01.2026.
//

import SwiftUI

struct ContentView: View {
//    let users = ["Tohru", "Yuki", "Kyo", "Sora"]
//    @State private var selection = Set<String>()
//    
//    @State private var selectedTab = "One"
    
    @State private var output = ""
    
    var body: some View {
//        VStack {
////            List(users, id: \.self, selection: $selection) {user in
////                Text(user)
////            }
////            
////            if selection.isEmpty == false {
////                Text("You selected \(selection.formatted())")
////            }
////            
////            EditButton()
////            TabView {
////                Text("Tab one")
////                    .tabItem {
////                        Label("One", systemImage: "house")
////                    }
////                Text("Tab two")
////                    .tabItem {
////                        Label ("Two", systemImage: "star")
////                    }
////                Text("Tab three")
////                    .tabItem {
////                        Label ("Three", systemImage: "person.3")
////                    }
////                
////            }
//            TabView(selection: $selectedTab) {
//                Button("Show tab 2") {
//                    selectedTab = "Two"
//                }
//                .tabItem {
//                    Label("One", systemImage: "star")
//                }
//                .tag("One")
//                
//                
//                Text("Tab 2")
//                    .tabItem {
//                        Label ("Two", systemImage: "circle")
//                    }
//                    .tag( "Two" )
//            }
//            
//        }
//        .padding()
        
        Text(output)
            .task {
                await fetchReadings()
            }
    }
    func fetchReadings() async {
        do {
        let url = URL(string: "https://hws.dev/readings.json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let readings = try JSONDecoder().decode([Double].self, from: data)
            output = "Found \(readings.count) readings"
        } catch {
            
        }
        
    }
}

#Preview {
    ContentView()
}
