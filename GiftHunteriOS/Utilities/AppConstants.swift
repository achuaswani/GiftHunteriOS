//
//  Constants.swift
//  GiftHunteriOS
//
//  Created by Aswani on 10/16/20.
//

struct AppConstants {
    // Intent extra to switch views for Cast
    static let SWITCHTOGAMERROM = 1
    static let SWITCHTOSCOREBOARD = 2
    static let SWITCHTOFINALSCORE = 3

    // Intent messages
    static let INTENTMSGID = "id"
    static let INTENTMSGPIN = "PIN"
    static let INTENTMSGNAME = "name"
    static let INTENTMSGDESC = "desc"
    static let INTENTMSGQUESTIONTITLE = "questionText"
    static let INTENTMSGQUESTIONANSWER = "answer"
    static let INTENTMSGQUESTIONFILEPATH = "media"

    // Firebase Nodes
    static let NODEALLPLAYERS = "AllPlayers"
    static let NODEACTIVEQUIZ = "ActiveQuiz"
    static let NODEPROFILE = "Profile"
    static let NODEQUESTIONSLIST = "QuestionsList"
    static let NODEQUIZZESLIST = "QuizzesList"
    static let NODESCOREBOARDS = "ScoreBoards"
    static let NODETOTALPOINTS = "points"
    // Time
    static let MAXSECONDS = 30
    static let POINTSMULTIPLIER = 10
    static let TIMEINTERVAL = 1

    static let WEBVIEWTESTURL = "http://localhost:3000"
}
