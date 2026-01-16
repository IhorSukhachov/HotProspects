//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Ihor Sukhachov on 16.01.2026.
//
import SwiftData
import SwiftUI

struct EditProspectView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var prospect: Prospect
    
    @State private var name: String
    @State private var email: String
    
    init(prospect: Prospect) {
        self.prospect = prospect
        _name = State(initialValue: prospect.name)
        _email = State(initialValue: prospect.emailAddress)
    }
    
    var body: some View {
            NavigationStack {
                Form {
                    Section("Contact information") {
                        TextField(prospect.name, text: $name)
                            .textContentType(.name)
                        
                        TextField(prospect.emailAddress, text: $email)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                    }
                }
                .navigationTitle("Edit Prospect")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Save") {
                                    save()
                                }
                            }
                        }
            }
        }
    func save() {
        prospect.name = name
        prospect.emailAddress = email
        dismiss()
    }
}

#Preview {
    EditProspectView(prospect: Prospect(name: "Test User", emailAddress: "test@example.com",isContacted: false))
        .modelContainer(for: Prospect.self)
}
