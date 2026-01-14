//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Ihor Sukhachov on 12.01.2026.
//
import CodeScanner
import SwiftData
import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    @State private var isShowingScanner = false
    
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
                        isShowingScanner = true
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
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}

