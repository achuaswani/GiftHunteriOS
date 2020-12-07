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
            let viewModel = CredentialsViewModel(session: session, loginView: false)
            CredentialsView(viewModel: viewModel)
        }
        .font(.system(size: 16, weight: .light, design: .rounded))
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
