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
    @EnvironmentObject var firebaseDataService: FirebaseDataService
    @EnvironmentObject var session: FirebaseSession

    var body: some View {
        header
        textFieldSection
        buttonView
    }

    var header:  some View {
        VStack {
            Text(viewModel.title)
                .accessibility(identifier: "title")
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .foregroundColor(Color("fontColor"))
                .opacity(0.8)
        }
    }

    var textFieldSection: some View {
        VStack(alignment: .leading, spacing: 15) {

            TextField("login.textfield.emailid.hint.text".localized(), text: $viewModel.email)
                .accessibility(identifier: "email")
                .padding()
                .background(Color("normalTextField"))
                .font(.system(size: 14, weight: .light, design: .rounded))
                .cornerRadius(20.0)
                .shadow(radius: 5.0, x: 5, y: 5)

            passwordTextField

            if viewModel.showErrorMessage {
                Text(viewModel.errorMessage)
                    .accessibility(identifier: "error")
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
            showPasswordTextFields(hintText: "login.textfield.password.hint.text".localized(),
                                   textValue: $viewModel.password)
                .accessibility(identifier: "password")
                .padding([.top, .bottom], 10)
            if !viewModel.loginView {
                showPasswordTextFields(hintText: "register.textfield.confirm.password.hint.text".localized(),
                                       textValue: $viewModel.confirmPassword)
                    .accessibility(identifier: "confirmPassword")
                    .padding([.top, .bottom], 10)
                TextField("register.textfield.username.title".localized(), text: $viewModel.displayName)
                    .accessibility(identifier: "displayName")
                    .padding()
                    .background(Color("normalTextField"))
                    .font(.system(size: 14, weight: .light, design: .rounded))
                    .cornerRadius(20.0)
                    .shadow(radius: 5.0, x: 5, y: 5)
                Divider()
                    .padding(.top, 10)
               roleSelectionView
            }
        }
    }
    
    var roleSelectionView: some View {
        ScrollView {
            ForEach(Role.allCases, id: \.self) { item in
                HStack {
                    if viewModel.selectedType == item {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                            .padding(.all)
                    } else {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.blue)
                            .padding(.all)
                    }
                    Text(item.rawValue)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.leading)
                        .position(x: 50, y: 10)
                        .padding(.all)
                }
                .onTapGesture {
                    viewModel.updatedSelection(item)
                }
                Divider()
            }
        }
    }

    var buttonView: some View {
        VStack {
            Button(action: {
                    viewModel.buttonAction(dataService: firebaseDataService, firebaseSession: session)
                }
            ) {
                Text(viewModel.title)
                    .frame(width: 300, height: 30)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                }
            .buttonStyle(BaseButtonStyle())
            .accessibility(identifier: "button")
            .padding([.top, .bottom], 50)
            .padding([.leading, .trailing], 27.5)
        }
    }

    func showPasswordTextFields(hintText: String, textValue: Binding<String>) -> AnyView {
       return AnyView(
            HStack {
                if showPassword {
                    TextField(hintText, text: textValue)
                        .font(.system(size: 14, weight: .light, design: .rounded))
                } else {
                   SecureField(hintText, text: textValue)
                    .font(.system(size: 14, weight: .light, design: .rounded))
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
            .background(Color("normalTextField"))
            .cornerRadius(20.0)
            .shadow(radius: 5.0, x: 5, y: 5)
       )
    }
}
