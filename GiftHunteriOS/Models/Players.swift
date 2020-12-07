//
//  ScoreBoard.swift
//  GiftHunteriOS
//
//  Created by Aswani on 12/4/20.
//

struct Player {
    var name: String
    var score: Int
    var rank: Int
    static let `default`  = Self(
        name: "",
        score: 0,
        rank: 0
    )
}
