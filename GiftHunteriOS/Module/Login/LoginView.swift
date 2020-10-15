//
//  LoginView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var passwordKey = ""
    @State private var showPassword = false
    @State private var isNavigationBarHidden = true
    @State var showErrorMessage = false
    @State var errorMessage = ""
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        NavigationView {
            VStack {
                header
                textFieldSection
                buttonView
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
    
    var header:  some View {
        VStack {
            Text("Login")
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .foregroundColor(Color.black)
                .opacity(0.8)
        }
    }
    
    var textFieldSection: some View {
        VStack(alignment: .leading, spacing: 15) {
          
          TextField("Email", text: self.$email)
            .padding()
            .background(Color.normalTextField)
            .cornerRadius(20.0)
            .shadow(radius: 5.0, x: 5, y: 5)
                        
            passwordTextField
            
            if showErrorMessage {
                Text(errorMessage)
                    .font(.system(size: 12, weight: .light, design: .rounded))
                    .foregroundColor(Color.red)
                    .opacity(0.8)
                    .lineLimit(2)
                    .padding([.leading, .trailing], 15)
            }
            
        }
        .padding([.leading, .trailing], 27.5)
    }
    
    var passwordTextField: some View {
        HStack {
            if showPassword {
                TextField("Password", text: self.$passwordKey)
            } else {
                SecureField("Password", text: self.$passwordKey)
            }
            Button(action: { self.showPassword.toggle()} ) {
                if self.showPassword {
                    Image(systemName: "eye")
                } else {
                    Image(systemName: "eye.slash")
                }
            }
        }
        .padding()
        .background(Color.normalTextField)
        .cornerRadius(20.0)
        .shadow(radius: 5.0, x: 5, y: 5)
    }
    
    var buttonView: some View {
        VStack {
            Button(action: signin) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.normalButton)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 5, y: 5)
            }
            .padding([.top, .bottom], 50)
            .padding([.leading, .trailing], 27.5)
        }
    }
    
    var forgotPasswrod: some View {
        VStack {
            Text("Forgot password?")
                .foregroundColor(.blue)
        }
    }
    
    var registerAccount: some View {
        HStack {
            Text("Don't have an account? ")
                .foregroundColor(Color.black)
                .opacity(0.8)
            NavigationLink(destination:
                            RegisterView()) {
                Text("Register")
                    .foregroundColor(.blue)
                
            }
        }
        .padding(.top, 50)
    }
    
    //MARK: Functions
    func signin() {
        session.login(email: email, password: passwordKey) { (result, error) in
            if error != nil {
                self.showErrorMessage = true
                self.errorMessage = error?.localizedDescription ?? "Error"
            } else {
                self.showErrorMessage = true
                self.errorMessage = ""
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
