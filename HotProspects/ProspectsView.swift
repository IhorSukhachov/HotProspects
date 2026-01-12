//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Ihor Sukhachov on 12.01.2026.
//

import SwiftData
import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            "All Prospects"
        case .contacted:
            "Contacted Prospects"
        case .uncontacted:
            "Uncontacted Prospects"
        }
    }
    
    var body: some View {
        NavigationStack {
            List(prospects) {prospect in
                VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundStyle(.secondary)
                    
                }
            }
                .navigationTitle(title)
                .toolbar {
                    Button("Scan",systemImage: "qrcode.viewfinder") {
                        let prospect = Prospect(name: "New Prospect", emailAddress: "new@prospect.com", isContacted: false)
                        modelContext.insert(prospect)
                    }
                }
        }
      
    }
    
    init(filter: FilterType) {
        self.filter = filter
        
        if filter != .none {
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly}, sort: [SortDescriptor(\Prospect.name)])
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}

