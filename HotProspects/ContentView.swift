//
//  ContentView.swift
//  HotProspects
//
//  Created by Ihor Sukhachov on 08.01.2026.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    var body: some View {
        VStack {
            Button("Requst Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {success, error in
                    if success {
                        print("All set")
                    } else if let error {
                        print("there was an error: \(error.localizedDescription )")
                    }
                    
                }
            }
        }
        
        VStack {
            Button("Send Notification") {
                
            }
        }
        
    }
}

#Preview {
    ContentView()
}
