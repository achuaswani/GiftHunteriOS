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
    @Published var displayName = ""
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
        Monitor().startMonitoring { [weak self] _, reachable in
            guard let self = self else { return }
            guard self.validateFields(reachable) else {
                return
            }

            self.sendAuthenticationRequest()
        }
    }

    func sendAuthenticationRequest() {
        if loginView {
            session.login(email: email, password: password) { [weak self] (result: Result<Bool, APIError>) in
                guard let self = self else {
                    return
                }
                switch result {
                case .success:
                    break
                case .failure(let error):
                    self.updateErrorMessage(error.localizedDescription)
                }
            }
        } else {
            guard self.validateRegisteration() else {
                return
            }
            session.register(email: email, password: password, displayName: displayName) { [weak self] (result: Result<Bool, APIError>) in
                    guard let self = self else {
                        return
                    }
                    switch result {
                    case .success:
                        break
                    case .failure(let error):
                        self.updateErrorMessage(error.localizedDescription)
                    }
            }
        }
    }

    func validateFields(_ reachable: Reachable) -> Bool {
        guard reachable == .yes else {
            updateErrorMessage(APIError.offline(message: "service.request.try.again".localized()).debugDescription)
            return false
        }
        guard !email.isEmpty, !password.isEmpty else {
            updateErrorMessage(APIError.allFieldsManditory.debugDescription)
            return false
        }
        guard email.isValidEmail else {
            updateErrorMessage(APIError.invalidEmail.debugDescription)
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
        guard !confirmPassword.isEmpty, !displayName.isEmpty  else {
            updateErrorMessage(APIError.allFieldsManditory.debugDescription)
            return false
        }
        guard password.isValidPassword else {
            updateErrorMessage(APIError.invalidPassword.debugDescription)
            return false
        }
        guard password == confirmPassword else {
            updateErrorMessage(APIError.passwordNotMatching.debugDescription)
            return false
        }
        return true
    }
}
