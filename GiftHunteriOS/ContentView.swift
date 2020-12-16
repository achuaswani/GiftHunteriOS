//
//  ContentView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: FirebaseSession
    @EnvironmentObject var dataService: FirebaseDataService

    var body: some View {
        Group {
            if session.isLoggedIn, dataService.isProfileLoaded {
                DashboardView()
            } else {
                LoginView()
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: getUser)
    }
    
    func getUser() {
        session.getUser()
        if let user = session.user {
            dataService.listen(uid: user.uid)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(FirebaseSession())
            .environmentObject(FirebaseDataService())
    }
}
#endif
