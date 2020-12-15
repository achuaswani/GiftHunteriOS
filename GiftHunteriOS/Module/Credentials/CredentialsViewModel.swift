//
//  CredentialsViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani on 10/16/20.
//

import SwiftUI

class CredentialsViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String = ""
    @Published var showErrorMessage: Bool = false
    @Published var title: String = ""
    @Published var displayName = ""
    @Published var selectedType: Role = .admin
    var loginView: Bool = false
    var session: FirebaseSession
    var emailRegistered = false
    var firebaseDataService: FirebaseDataService?

    init(session: FirebaseSession, loginView: Bool) {
        self.session = session
        self.loginView = loginView
        if loginView {
            title = "login.button.login.title".localized()
        } else {
            session.cancelListening()
            title = "login.button.register.title".localized()
        }
    }
    
    func updatedSelection(_ item: Role) {
        selectedType = item
    }

    func buttonAction(dataService: FirebaseDataService) {
        firebaseDataService = dataService
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
                    self.updateErrorMessage(error.debugDescription)
                }
            }
        } else {
            guard self.validateRegisteration() else {
                return
            }
            registerUser()
        }
    }
    
    func registerUser() {
        let profileUpdateHandler = {[weak self] (result: Result<Bool, APIError>) in
            guard let self = self else {
                return
            }
            switch result {
            case .success:
                self.createProfile()
            case .failure(let error):
                self.updateErrorMessage(error.debugDescription)
            }
            
        }
        self.session.register(email: self.email,
                              password: self.password,
                              handler: profileUpdateHandler)
        
    }
    
    func createProfile() {
        guard let user = session.user else {
            return
        }
        let profile = Profile(userName: self.displayName, userId: user.uid, role: selectedType, quizPIN: [])
        firebaseDataService?.updateProfile(userValue: profile) { error in
            if error != nil {
                self.updateErrorMessage(APIError.profileNotUpdated.debugDescription)
            } else {
                self.session.listen()
                self.firebaseDataService?.updateToUserNamesList()
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
