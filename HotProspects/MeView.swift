//
//  MeView.swift
//  HotProspects
//
//  Created by Ihor Sukhachov on 12.01.2026.
//

import SwiftUI

struct MeView: View {
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "Anonymous@example.com"
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("name", text: $name)
                    .textContentType(.name)
                TextField("email address", text: $emailAddress)
                    .textContentType(.emailAddress)
            }
           
        }
    }
}

#Preview {
    MeView()
}
