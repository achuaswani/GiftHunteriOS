//
//  FirebaseSession.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCrashlytics

class FirebaseSession: ObservableObject {

    // MARK: Properties
    @Published var user: User?
    @Published var isLoggedIn: Bool = false

    // MARK: Functions
    func listen() {
        _ = Auth.auth().addStateDidChangeListener { (_, user) in
            if let user = user {
                self.user = User(
                    uid: user.uid,
                    email: user.email,
                    displayName: user.displayName,
                    photoURL: user.photoURL
                )
                self.isLoggedIn = true
                self.setUserIdToCrashlytics(user.uid)
            } else {
                self.isLoggedIn = false
                self.user = nil
            }
        }
    }

    func login(email: String, password: String, handler: @escaping(Result<Bool, APIError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if user != nil {
                handler(.success(true))
            } else {
                if let error = error, let errCode = Status(rawValue: error._code) {
                    switch errCode {
                    case .authErrorCodeWrongPassword:
                        handler(.failure(.wrongPassword(message: error.localizedDescription)))
                    case .authErrorCodeInvalidCredential:
                        handler(.failure(.wrongEmailOrPassword))
                    default:
                        handler(.failure(.genericError(error: error)))
                    }
                }
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.user = nil
        } catch {
            debugPrint("cannot signout")
        }
    }

    func register(email: String, password: String, displayName: String, handler: @escaping(Result<Bool, APIError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if user != nil {
                self.updateUserDetails(userName: displayName, profilePicture: nil) { _ in
                    handler(.success(true))
                }
            } else {
                if let error = error, let errCode = Status(rawValue: error._code) {
                    switch errCode {
                    case .authErrorCodeWrongPassword:
                        handler(.failure(.wrongPassword(message: error.localizedDescription)))
                    case .authErrorCodeInvalidCredential:
                        handler(.failure(.wrongEmailOrPassword))
                    default:
                        handler(.failure(.genericError(error: error)))
                    }
                }
            }
        }
    }

    func updateUserDetails(userName: String?, profilePicture: URL?, handler: @escaping  UserProfileChangeCallback) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        if userName != nil {
            changeRequest?.displayName = userName
        }
        if profilePicture != nil {
            changeRequest?.photoURL = profilePicture
        }

        changeRequest?.commitChanges(completion: handler)
    }

    func updateEmailId(to email: String, handler: @escaping UserProfileChangeCallback) {
        Auth.auth().currentUser?.updateEmail(to: email, completion: handler)
    }

    func updatePassword(to password: String, handler: @escaping UserProfileChangeCallback) {
        Auth.auth().currentUser?.updatePassword(to: password, completion: handler)
    }

    func reauthenticate(password: String, handler: @escaping AuthDataResultCallback) {
        guard let user = Auth.auth().currentUser, let email = user.email else { return }
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        user.reauthenticate(with: credential, completion: handler)
    }

    func setUserIdToCrashlytics(_ userId: String) {
        Crashlytics.crashlytics().setUserID(userId)
    }
}
