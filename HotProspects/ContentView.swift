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
                let content = UNMutableNotificationContent()
                content.title = "Feed thr cat"
                content.subtitle = "It's time to feed the cat"
                content.sound = .default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
