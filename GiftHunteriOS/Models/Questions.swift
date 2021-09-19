//
//  Quiz.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/7/20.
//

struct Question: Codable, Hashable {
    var questionText: String
    var answer: String
    var options: [String]
    var media: String
    static let `default`  = Self(
        questionText: "",
        answer: "",
        options: ["", "", "", ""],
        media: ""
    )
    
    func getQuizDictionary() -> [String: Any] {
        return [
            "questionText": self.questionText,
            "options": self.options,
            "answer": self.answer,
            "media": self.media
        ]
    }
}
