//
//  RegisterView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        VStack {
            CredentialsView(title: "Register",
                            loginView: false)
        }
        .font(.system(size: 16, weight: .light, design: .rounded))
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
