//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Ihor Sukhachov on 08.01.2026.
//
import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
