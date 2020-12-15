//
//  UserResults.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/13/20.
//

import Foundation

struct UserResult: Hashable {
    var pin: String
    var userName: String
    var score: Int
    var quizDetails: Quiz
    static let `default` = Self(pin: "", userName: "", score: 0, quizDetails: Quiz.default)
}
