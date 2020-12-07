//
//  ResponseHandler.swift
//  GiftHunteriOS
//
//  Created by Aswani on 10/16/20.
//

import Foundation

enum ResponseHandler {
    case NoInternetConnection
    case AllFieldsManditory
    case InvalidEmail
    case InvalidPassword
    case NoPassword
    case PasswordNotMatching
    case WrongEmailOrPassword
    case Success
    
    func responseValue() -> String {
        switch self {
        case .NoInternetConnection:
            return "No internet connection"
        case .AllFieldsManditory:
            return "All fields are manditory"
        case .InvalidEmail:
            return "Invalid email"
        case .InvalidPassword:
            return "Invalid password"
        case .NoPassword:
            return "No password specified"
        case .PasswordNotMatching:
            return "Confirm password is not matching with password"
        case .WrongEmailOrPassword:
            return "Email or password wrong"
        case .Success:
            return "Success"
        }
    }
}
