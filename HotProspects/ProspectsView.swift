//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Ihor Sukhachov on 12.01.2026.
//
import CodeScanner
import SwiftData
import SwiftUI
internal import AVFoundation
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortOption: String, CaseIterable {
        case name = "Name"
        case recent = "Most Recent"
    }
    @AppStorage("sortOption") private var sortOption: SortOption = .name
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.createdAt) private var allProspects: [Prospect]
    
    @State private var isShowingScanner = false
    @State private var selectedProspects =  Set<Prospect>()
    
    private var prospects: [Prospect] {
        var filtered = allProspects
        switch filter {
        case .contacted:
            filtered = filtered.filter { $0.isContacted }
        case .uncontacted:
            filtered = filtered.filter { !$0.isContacted }
        case .none:
            break
        }

        switch sortOption {
        case .name:
            return filtered.sorted { $0.name < $1.name }
        case .recent:
            return filtered.sorted { $0.createdAt > $1.createdAt }
        }
    }
    
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
            List(prospects, selection: $selectedProspects) {prospect in
                NavigationLink {
                    EditProspectView(prospect: prospect)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundStyle(.secondary)
                            Text(prospect.createdAt.formatted())
                            
                        }
                        Spacer()
                        if filter == .none {
                            prospect.isContacted ? Image(systemName: "person.crop.circle.fill.badge.checkmark").foregroundStyle(.green) : Image(systemName: "person.crop.circle.badge.xmark").foregroundStyle(.red)
                            
                        }
                    }
                }

                .swipeActions {
                    Button("Delete contact", systemImage: "trash", role: .destructive) {
                        modelContext.delete(prospect)
                        
                    }
                    
                    if prospect.isContacted {
                        Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)
                    }
                    else {
                        Button("Mark Contacted", systemImage: "person.crop.fill.badge.checkmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)
                        
                        Button("Remind Me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }
                        .tint(.orange)
                    }
                }
                .tag(prospect)
            }
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Scan",systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                            }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Sort by", selection: $sortOption) {
                                ForEach(SortOption.allCases, id: \.self) {
                                    Text($0.rawValue)
                                }
                            }
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    
                    if selectedProspects.isEmpty == false {
                        ToolbarItem(placement: .bottomBar) {
                            Button("Delete selected", action: delete)
                        }
                    }
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Ihor Sukhachov\nsample@example.com", completion: handleScan)
                }
        }
  
      
    }
    
    init(filter: FilterType) {
        self.filter = filter

        let predicate: Predicate<Prospect>? = {
            switch filter {
            case .none:
                return nil 
            case .contacted:
                return #Predicate { $0.isContacted }
            case .uncontacted:
                return #Predicate { !$0.isContacted }
            }
        }()
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
            
        }
    }
    
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings {
            settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                 center.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
                    guard success else { return }
                    addRequest()
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}

