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
                .font(BaseStyle.headerFont)
                .foregroundColor(Color("fontColor"))
                .opacity(0.8)
                .padding(.all, 2)
        }
    }

    var textFieldSection: some View {
        VStack(alignment: .leading, spacing: 15) {

            TextField("login.textfield.emailid.hint.text".localized(), text: $viewModel.email)
                .accessibility(identifier: "email")
                .padding(.all, BaseStyle.innerSpacing)
                .background(Color("normalTextField"))
                .font(BaseStyle.normalFont)
                .cornerRadius(BaseStyle.cornerRadius)
                .shadow(radius: 5.0, x: 5, y: 5)
                .padding(.bottom, BaseStyle.outerSpacing)

            passwordTextFields

            if viewModel.showErrorMessage {
                Text(viewModel.errorMessage)
                    .accessibility(identifier: "error")
                    .font(.system(size: 12, weight: .light, design: .rounded))
                    .foregroundColor(Color.red)
                    .opacity(0.8)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding(.all, BaseStyle.innerSpacing)
            }

        }
        .padding([.leading, .trailing], 27.5)
    }

    var passwordTextFields: some View {
        VStack {
            showPasswordTextFields(hintText: "login.textfield.password.hint.text".localized(),
                                   textValue: $viewModel.password)
                .accessibility(identifier: "password")
                .padding(.bottom, BaseStyle.outerSpacing)
            if !viewModel.loginView {
                showPasswordTextFields(hintText: "register.textfield.confirm.password.hint.text".localized(),
                                       textValue: $viewModel.confirmPassword)
                    .accessibility(identifier: "confirmPassword")
                    .padding(.bottom, BaseStyle.outerSpacing)
                TextField("register.textfield.username.title".localized(), text: $viewModel.displayName)
                    .accessibility(identifier: "displayName")
                    .padding(.all, BaseStyle.innerSpacing)
                    .background(Color("normalTextField"))
                    .font(BaseStyle.normalFont)
                    .cornerRadius(BaseStyle.cornerRadius)
                    .shadow(radius: 5.0, x: 5, y: 5)
                    .padding(.bottom, BaseStyle.outerSpacing)
                   
                Divider()
                    .padding(.all, BaseStyle.innerSpacing)
               roleSelectionView
            }
        }
    }

    func showPasswordTextFields(hintText: String, textValue: Binding<String>) -> AnyView {
       return AnyView(
            HStack {
                if showPassword {
                    TextField(hintText, text: textValue)
                        .font(BaseStyle.normalFont)
                } else {
                   SecureField(hintText, text: textValue)
                        .font(BaseStyle.normalFont)
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
            .padding(.all, BaseStyle.innerSpacing)
            .background(Color("normalTextField"))
            .cornerRadius(BaseStyle.cornerRadius)
            .shadow(radius: 5.0, x: 5, y: 5)
       )
    }
    
    var roleSelectionView: some View {
        ForEach(Role.allCases, id: \.self) { item in
            HStack {
                if viewModel.selectedType == item {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        
                } else {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.blue)
                }
                Text(item.rawValue)
                    .font(BaseStyle.normalFont)
                    .multilineTextAlignment(.leading)
            }
            .padding(.all, BaseStyle.innerSpacing)
            .onTapGesture {
                viewModel.updatedSelection(item)
            }
            Divider()
        }
    }
    
    var buttonView: some View {
        VStack {
            Button(action: {
                    viewModel.buttonAction(dataService: firebaseDataService, firebaseSession: session)
                }
            ) {
                Text(viewModel.title)
            }
            .buttonStyle(BaseButtonStyle())
            .accessibility(identifier: "\(viewModel.title)button")
        }
    }

}
