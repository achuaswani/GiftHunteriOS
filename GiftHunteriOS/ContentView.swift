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
            if session.isLoggedIn {
                Group {
                    if dataService.profile != nil {
                        DashboardView()
                    } else {
                        LoginView()
                    }
                }.onAppear(perform: gerProfile)
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
    
    func gerProfile() {
        dataService.listen()
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
