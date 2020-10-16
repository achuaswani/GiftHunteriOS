//
//  CredentialsView.swift
//  GiftHunteriOS
//
//  Created by Aswani on 10/15/20.
//

import SwiftUI

struct CredentialsView: View {
    
    @EnvironmentObject var session: FirebaseSession
    var title: String
    var loginView: Bool = false
    @State var confirmPassword = ""
    @State var showPassword = false
    @State var email: String = ""
    @State var password: String = ""
    @State var showErrorMessage: Bool = false
    @State var errorMessage: String = ""
    
    var body: some View {
        header
        textFieldSection
        buttonView
    }
    
    var header:  some View {
        VStack {
            Text(title)
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
        VStack {
            showPasswordTextFields(hintText: "Password", textValue: self.$password)
                .padding([.top, .bottom], 10)
            if !loginView {
                showPasswordTextFields(hintText: "Confirm password", textValue: self.$confirmPassword)
                .padding([.top, .bottom], 10)
            }
        }
    }
    
    var buttonView: some View {
        VStack {
            Button(action: buttonAction) {
                Text(title)
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
    
    func buttonAction() {
        if loginView {
            session.login(email: email, password: password) { (result, error) in
                displayErrorMessage(error: error)
            }
        } else {
            session.register(email: email, password: password) { (result, error) in
                displayErrorMessage(error: error)
            }
        }
    }
    
    func displayErrorMessage(error: Error?) {
        if error != nil {
            self.showErrorMessage = true
            self.errorMessage = error?.localizedDescription ?? "Error"
        } else {
            self.showErrorMessage = true
            self.errorMessage = ""
        }
    }
    
    func showPasswordTextFields(hintText: String, textValue: Binding<String>) -> AnyView {
       return AnyView(
            HStack {
                if showPassword {
                    TextField(hintText, text: textValue)
                } else {
                   SecureField(hintText, text: textValue)
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
       )
    }
}
