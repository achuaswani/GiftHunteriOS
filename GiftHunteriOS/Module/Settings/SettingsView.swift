//
//  SettingsView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var session: FirebaseSession
    @EnvironmentObject var firebaseDataService: FirebaseDataService

    var body: some View {
        VStack {
            content
        }
    }

    var content: some View {
        List {

            NavigationLink(destination: AccountSettingsView()) {
                Label("Account Settings", systemImage: "doc.badge.gearshape.fill")
            }
            NavigationLink(destination: AboutView()) {
                Label("About Us", systemImage: "pencil.circle.fill")
            }
            //Label("Help", systemImage: "questionmark.square.fill")
            Label("Signout", systemImage: "power")
                .onTapGesture {
                    session.logout()
                    firebaseDataService.clearData()
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
