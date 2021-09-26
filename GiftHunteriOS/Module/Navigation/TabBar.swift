//
//  TabBar.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI

struct TabBar: View {

    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image(systemName: "person.fill.questionmark")
                Text("Quiz")
                    .font(.system(size: 12, weight: .light, design: .rounded))
            }
            NavigationView {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
                    .font(.system(size: 12, weight: .light, design: .rounded))
            }

        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        let dataService = FirebaseDataService()
        dataService.profile = Profile.default
        return TabBar()
                .environmentObject(dataService)
    }
}
