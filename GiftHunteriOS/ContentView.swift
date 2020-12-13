//
//  ContentView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: FirebaseSession

    var body: some View {
        Group {
            if session.isLoggedIn, session.user?.displayName != nil {
                DashboardView()
            } else {
                LoginView()
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: getUser)
    }

    func getUser() {
        session.listen()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(FirebaseSession())
    }
}
#endif
