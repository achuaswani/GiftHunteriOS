//
//  Quiz.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/7/20.
//

import Foundation

struct QuizSet: Codable{
    var quiz: [Quiz]
    static let `default`  = Self(quiz: [Quiz.default])
}

struct Quiz: Codable {
    var question : String
    var answer : String
    var options: [String]
    static let `default`  = Self(question: "", answer: "", options: ["", "", "",  ""])
}
