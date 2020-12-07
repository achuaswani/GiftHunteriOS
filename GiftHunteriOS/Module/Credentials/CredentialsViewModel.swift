//
//  CredentialsViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani on 10/16/20.
//

import SwiftUI

protocol CredentialsViewModelType {
    func buttonAction()
}

class CredentialsViewModel: ObservableObject, CredentialsViewModelType {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String = ""
    @Published var showErrorMessage: Bool = false
    @Published var title: String = ""
    var loginView: Bool = false
    var session: FirebaseSession
    
    init(session: FirebaseSession, loginView: Bool) {
        self.session = session
        self.loginView = loginView
        if loginView {
            title = "login.button.login.title".localized()
        } else {
            title = "login.button.register.title".localized()
        }
    }
    
    func buttonAction() {
        Monitor().startMonitoring { [weak self] connection, reachable in
            guard let self = self else { return }
            guard self.validateFields(reachable) else {
                return
            }
                        
            self.sendAuthenticationREquestion()
        }
    }
    
    func sendAuthenticationREquestion() {
        if loginView {
            session.login(email: email, password: password) { [weak self] (_, error) in
                self?.updateErrorMessage(error?.localizedDescription ??
                                        ResponseHandler.WrongEmailOrPassword.responseValue())
            }
        } else {
            guard self.validateRegisteration() else {
                return
            }
            session.register(email: email, password: password) { [weak self] (_, error) in
                self?.updateErrorMessage(error?.localizedDescription ??
                                        ResponseHandler.WrongEmailOrPassword.responseValue())
            }
        }
    }
    
    func validateFields(_ reachable: Reachable) -> Bool {
        guard reachable == .yes else {
            updateErrorMessage(ResponseHandler.NoInternetConnection.responseValue())
            return false
        }
        guard !email.isEmpty, !password.isEmpty else {
            updateErrorMessage(ResponseHandler.AllFieldsManditory.responseValue())
            return false
        }
        guard !password.isEmpty else {
            updateErrorMessage(ResponseHandler.NoInternetConnection.responseValue())
            return false
        }
        guard email.isValidEmail else {
            updateErrorMessage(ResponseHandler.InvalidEmail.responseValue())
            return false
        }
        return true
    }
    
    func updateErrorMessage(_ message: String) {
        async { [weak self] in
            self?.showErrorMessage = true
            self?.errorMessage = message
        }
    }
    
    func validateRegisteration() -> Bool {
        guard !confirmPassword.isEmpty else {
            updateErrorMessage(ResponseHandler.AllFieldsManditory.responseValue())
            return false
        }
        guard password.isValidPassword else {
            updateErrorMessage(ResponseHandler.InvalidPassword.responseValue())
            return false
        }
        guard password == confirmPassword else {
            updateErrorMessage(ResponseHandler.PasswordNotMatching.responseValue())
            return false
        }
        return true
    }
}
