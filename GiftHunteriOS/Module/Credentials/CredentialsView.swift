//
//  CredentialsView.swift
//  GiftHunteriOS
//
//  Created by Aswani on 10/15/20.
//

import SwiftUI

struct CredentialsView: View {
    @ObservedObject var viewModel: CredentialsViewModel
    @State var showPassword = false
    
    init(viewModel: CredentialsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        header
        textFieldSection
        buttonView
    }
    
    var header:  some View {
        VStack {
            Text(viewModel.title)
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .foregroundColor(Color.black)
                .opacity(0.8)
        }
    }
    
    var textFieldSection: some View {
        VStack(alignment: .leading, spacing: 15) {
          
            TextField("Email", text: $viewModel.email)
            .padding()
            .background(Color.normalTextField)
            .cornerRadius(20.0)
            .shadow(radius: 5.0, x: 5, y: 5)
                        
            passwordTextField
            
            if viewModel.showErrorMessage {
                Text(viewModel.errorMessage)
                    .font(.system(size: 12, weight: .light, design: .rounded))
                    .foregroundColor(Color.red)
                    .opacity(0.8)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 15)
            }
            
        }
        .padding([.leading, .trailing], 27.5)
    }
    
    var passwordTextField: some View {
        VStack {
            showPasswordTextFields(hintText: "Password", textValue: $viewModel.password)
                .padding([.top, .bottom], 10)
            if !viewModel.loginView {
                showPasswordTextFields(hintText: "Confirm password", textValue: $viewModel.confirmPassword)
                .padding([.top, .bottom], 10)
            }
        }
    }
    
    var buttonView: some View {
        VStack {
            Button(action: viewModel.buttonAction) {
                Text(viewModel.title)
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

    func showPasswordTextFields(hintText: String, textValue: Binding<String>) -> AnyView {
       return AnyView(
            HStack {
                if showPassword {
                    TextField(hintText, text: textValue)
                } else {
                   SecureField(hintText, text: textValue)
                }
                Button(action: {
                    self.showPassword.toggle()
                }) {
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
