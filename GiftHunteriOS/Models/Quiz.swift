//
//  Quiz.swift
//  GiftHunteriOS
//
//  Created by Aswani on 12/4/20.
//

struct Quiz: Codable, Hashable {
    var quizId: String
    var title: String
    var quizDetails: String
    var scoreBoardId: String
    var hostId: String
    static let `default`  = Self(
        quizId: "Test",
        title: "Test title",
        quizDetails: "Test Details",
        scoreBoardId: "12345",
        hostId: "12345"
    )
    
    func getQuizDictionary() -> [String: String] {
        return ["quizId": self.quizId,
                "title": self.title,
                "quizDetails": self.quizDetails,
                "scoreBoardId": self.scoreBoardId,
                "hostId": self.hostId
        ]
    }
}

struct QuizWithPIN: Hashable {
    var pin: String
    var quiz: Quiz
    static let `default`  = Self(
        pin: "",
        quiz: Quiz.default
    )
}
