//
//  LoginView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI

struct LoginView: View {
    @State private var showPassword = false
    @State private var isNavigationBarHidden = true
    @State var showErrorMessage = false
    @State var errorMessage = ""

    var body: some View {
        NavigationView {
            VStack {
                let viewModel = CredentialsViewModel(loginView: true)
                CredentialsView(viewModel: viewModel)
                forgotPasswrod
                registerAccount
            }
            .font(BaseStyle.normalFont)
        }
        .navigationBarHidden(isNavigationBarHidden)
        .onAppear {
            self.isNavigationBarHidden = true
        }
        .onDisappear {
            self.isNavigationBarHidden = false
        }
    }

    var forgotPasswrod: some View {
        VStack {
            Text("Forgot password?")
                .foregroundColor(.blue)
                .font(BaseStyle.normalFont)
        }
    }

    var registerAccount: some View {
        HStack {
            Text("Don't have an account? ")
                .foregroundColor(Color("fontColor"))
                .opacity(0.8)
                .font(BaseStyle.normalFont)
            NavigationLink(destination: RegisterView()) {
                Text("Register")
                    .foregroundColor(.blue)
                    .font(BaseStyle.normalFont)
            }
        }
        .padding(.top, 50)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .previewDevice("iPod touch (7th generation)")
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            LoginView()
                .previewDevice("iPhone 12 Pro Max")
        }
    }
}
