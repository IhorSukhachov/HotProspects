//
//  ContentView.swift
//  HotProspects
//
//  Created by Ihor Sukhachov on 08.01.2026.
//

import SamplePackage
import SwiftUI
import UserNotifications

struct ContentView: View {
    let possibleNumbers = Array(1...60)
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    
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
        Text(results)
        
    }
}

#Preview {
    ContentView()
}
