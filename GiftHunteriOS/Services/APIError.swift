//
//  APIError.swift
//  GiftHunteriOS
//
//  Created by Aswani on 10/16/20.
//

import Foundation

enum APIError: Error {
    case allFieldsManditory
    case invalidEmail
    case invalidPassword
    case noPassword
    case passwordNotMatching
    case wrongEmailOrPassword
    case wrongPassword(message: String)
    case sessionError(cause: Error)
    case apiError(status: Int, message: String? = nil)
    case parsingError
    case missingDataError
    case requestError
    case timeoutError
    case offline(message: String)
    case internalServerError
    case notFound
    case genericError(error: Error)

    var debugDescription: String {
        switch self {
        case .allFieldsManditory:
            return "All fields are manditory"
        case .invalidEmail:
            return "Invalid email"
        case .invalidPassword:
            return "Invalid password"
        case .noPassword:
            return "No password specified"
        case .passwordNotMatching:
            return "Confirm password is not matching with password"
        case .wrongEmailOrPassword:
            return "Email or password wrong"
        case .wrongPassword(let message):
            return message
        case .sessionError(let cause):
            return "service.response.session.error".localized() + " \(cause.localizedDescription)"
        case .apiError(let status, let message):
            return "service.response.api.error" + "\(status), \(message ?? "")"
        case .parsingError:
            return "service.response.parsing.error".localized()
        case .missingDataError:
            return "service.response.missing.data.error".localized()
        case .requestError:
            return "service.request.session.timeout".localized()
        case .timeoutError:
            return "service.request.error".localized() + "service.request.try.again".localized()
        case .offline(let message):
            return "\(message)"
        case .internalServerError:
            return "service.request.internal.server.error".localized()
        case .notFound:
            return "service.request.page.not.found".localized()
        case .genericError(let error):
            return error.localizedDescription

        }
    }
}
