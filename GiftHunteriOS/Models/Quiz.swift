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
        quizId: "",
        title: "",
        quizDetails: "",
        scoreBoardId: "",
        hostId: ""
    )
}
