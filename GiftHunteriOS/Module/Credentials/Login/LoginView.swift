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
            .font(.system(size: 16, weight: .light, design: .rounded))
        }
        .navigationBarHidden(isNavigationBarHidden)
        .navigationBarTitle("")
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
                .font(.system(size: 16, weight: .light, design: .rounded))
        }
    }

    var registerAccount: some View {
        HStack {
            Text("Don't have an account? ")
                .foregroundColor(Color("fontColor"))
                .opacity(0.8)
                .font(.system(size: 16, weight: .light, design: .rounded))
            NavigationLink(destination: RegisterView()) {
                Text("Register")
                    .foregroundColor(.blue)
                    .font(.system(size: 16, weight: .light, design: .rounded))
            }
        }
        .padding(.top, 50)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
