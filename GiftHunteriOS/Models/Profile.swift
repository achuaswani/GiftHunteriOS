//
//  Profile.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/12/20.
//

struct Profile: Codable {
    var userName: String
    var userId: String
    var role: Role
    var userDisplayPicture: String?
    var quizPIN: [String]?
    static let `default` = Self(userName: "", userId: "", role: .student )
    
    init(
        userName: String,
        userId: String,
        role: Role,
        userDisplayPicture: String? = nil,
        quizPIN: [String]? = []
    ) {
        self.userName = userName
        self.userId = userId
        self.role = role
        self.userDisplayPicture = userDisplayPicture
        self.quizPIN = quizPIN
    }
}

enum Role: String, Codable, CaseIterable {
    case teacher
    case student
}
