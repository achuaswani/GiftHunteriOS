//
//  Quiz.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/7/20.
//

struct Question: Codable {
    var id: String
    var questionText: String
    var answer: String
    var options: [String]
    var media: String
    static let `default`  = Self(
        id: "",
        questionText: "",
        answer: "",
        options: ["", "", "", ""],
        media: ""
    )
    
    func getQuizDictionary() -> [String: Any] {
        return ["id": self.id,
                "questionText": self.questionText,
                "options": self.options,
                "answer": self.answer,
                "media": self.media]
    }
}
