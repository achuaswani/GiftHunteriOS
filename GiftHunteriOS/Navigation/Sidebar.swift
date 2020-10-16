//
//  Sidebar.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        NavigationView {
            #if os(iOS)
            content
                .navigationTitle("Quiz")
            #else
            content
                .frame(minWidth: 200, idealWidth: 250, maxWidth: 300)
            #endif
        }
    }
    
    var content: some View {
        List {
            NavigationLink(destination: HomeView()) {
             Label("Home", systemImage: "homekit")
            }
            NavigationLink(destination: SettingsView()) {
             Label("Settings", systemImage: "gearshape")
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Dashbaord")
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
