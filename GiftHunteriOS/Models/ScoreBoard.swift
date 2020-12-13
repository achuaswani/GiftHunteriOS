//
//  ScoreBoard.swift
//  GiftHunteriOS
//
//  Created by Aswani on 12/4/20.
//

struct ScoreBoard: Hashable {
    var name: String
    var score: Int
    var rank: Int
    static let `default`  = Self(
        name: "Test Name",
        score: 10,
        rank: 1
    )
}
