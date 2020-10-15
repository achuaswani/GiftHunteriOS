//
//  RegisterView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var passwordKey = ""
    @State private var confirmPassword = ""
    @State private var showErrorMessage = false
    @State private var showPassword = false
    @State private var errorMessage = ""
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        VStack {
            header
            textFieldSection
            buttonView
        }
        .font(.system(size: 16, weight: .light, design: .rounded))
    }
    
    var header:  some View {
        VStack {
            Text("Register")
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
                        
            passwordTextFields
            
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
    
    var passwordTextFields: some View {
        VStack {
            showPasswordTextFields(hintText: "Password", textValue: self.$passwordKey)
                .padding([.top, .bottom], 10)
            showPasswordTextFields(hintText: "Confirm password", textValue: self.$confirmPassword)
                .padding([.top, .bottom], 10)
        }
        
    }
    
    var buttonView: some View {
        VStack {
            Button(action: register) {
                Text("Register")
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
    
    //MARK: Functions
    func register() {
        session.register(email: email, password: passwordKey) { (result, error) in
            if error != nil {
                self.showErrorMessage = true
                self.errorMessage = error?.localizedDescription ?? "Error"
            } else {
                self.showErrorMessage = true
                self.errorMessage = ""
            }
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
