//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Ihor Sukhachov on 16.01.2026.
//
import SwiftData
import SwiftUI

struct EditProspectView: View {
    @Bindable var prospect: Prospect
    
    var body: some View {
        TextField(prospect.name, text: $prospect.name)
        TextField(prospect.emailAddress, text: $prospect.emailAddress)
    }
}

#Preview {
    EditProspectView(prospect: Prospect(name: "Test", emailAddress: "Test", isContacted: false))
        .modelContainer(for: Prospect.self)
}
