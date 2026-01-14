//
//  MeView.swift
//  HotProspects
//
//  Created by Ihor Sukhachov on 12.01.2026.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "Anonymous@example.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                TextField("email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
            }
            .navigationTitle("Your Code")
           
        }
    }
}

#Preview {
    MeView()
}
