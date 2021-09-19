//
//  GiftHunteriOSApp.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI
import FirebaseCore

@main
struct GiftHunteriOSApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(FirebaseSession())
                .environmentObject(FirebaseDataService())
        }
    }
}
