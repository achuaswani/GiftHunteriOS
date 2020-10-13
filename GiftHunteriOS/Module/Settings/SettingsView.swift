//
//  SettingsView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var session: FirebaseSession
    var body: some View {
        content
    }
    
    var content: some View {
        List {
            NavigationLink(destination: AboutView()) {
                Label("Profile", systemImage: "pencil.circle.fill")
            }
            NavigationLink(destination: AccountSettingsView()) {
                Label("Account Settings", systemImage: "doc.badge.gearshape")
            }
            Label("Signout", systemImage: "power")
                .onTapGesture {
                    session.logout()
                }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
