//
//  RegisterView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI

struct RegisterView: View {

    var body: some View {
        VStack {
            let viewModel = CredentialsViewModel(loginView: false)
            CredentialsView(viewModel: viewModel)
        }
        .padding(.top, -50)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RegisterView()
                .previewDevice("iPod touch (7th generation)")
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            RegisterView()
                .previewDevice("iPhone 12 Pro Max")
        }
    }
}
