//
//  QuizService.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/16/20.
//

import FirebaseDatabase
import CodableFirebase

class QuizService {
    var databasePINReference = Database.database().reference().child(AppConstants.NODEACTIVEQUIZ)
    var databaseQuestinsReference = Database.database().reference().child(AppConstants.NODEQUESTIONSLIST)
    var databaseScoreBoardReference = Database.database().reference().child(AppConstants.NODESCOREBOARDS)
    
    // MARK: - Quiz details
    func fetchQuestions(quizId: String, handler: @escaping ([Question]?, Error?) -> Void) {
        let questionsReference = databaseQuestinsReference.child(quizId)
        questionsReference.observeSingleEvent(of: .value, with: { snapshot in
           guard let value = snapshot.value else {
                return
           }
           do {
               let questionsSet = try FirebaseDecoder().decode([Question].self, from: value)
                handler(questionsSet, nil)
           } catch let error {
               handler(nil, error)
           }
        })
    }
    
    // MARK: - Verify Quiz PIN
    
    func verifyQuizPIN(pin: String, handler: @escaping (Quiz?) -> Void) {
        databasePINReference.observeSingleEvent(of: .value, with: { snapshot in
            let snapshot = snapshot.childSnapshot(forPath: pin)
            guard let value = snapshot.value else {
                handler(nil)
                return
            }
            do {
                
                let quiz = try FirebaseDecoder().decode(Quiz.self, from: value)
                handler(quiz)
            } catch let error {
                debugPrint(error.localizedDescription)
                handler(nil)
            }
        })
    }
    
    // MARK: - Create New Quiz
    func createNewQuiz(pin: String, quiz: Quiz) {
        databasePINReference.child(pin).setValue(quiz) { (error: Error?, ref: DatabaseReference) in
            if let error = error {
              print("Data could not be saved: \(error).")
            } else {
              print("Data saved successfully!")
            }
          }
    }
    
    
    // MARK: - Fetch Scoreboard
    
    func fetchScoreBoard(scoreBoardId: String, handler: @escaping ([ScoreBoard]?) -> Void) {
        databaseScoreBoardReference.child(scoreBoardId).observeSingleEvent(of: .value, with: { snapshot in
            var scoreBoard = [ScoreBoard]()
            for player in snapshot.children.allObjects {
                guard let playerItem = player as? DataSnapshot else {
                    handler(nil)
                    return
                }
                let playerName = playerItem.key
                let playerPoints = playerItem.childSnapshot(forPath: "score").value as! Int
                scoreBoard.append(ScoreBoard(name: String(playerName), score: playerPoints, rank: 0))
            }
            for pass in 0..<scoreBoard.count {
                for currentPoistion in pass+1..<scoreBoard.count where (scoreBoard[pass].score) < (scoreBoard[currentPoistion].score) {
                    let tmp = scoreBoard[pass]
                    scoreBoard[pass] = scoreBoard[currentPoistion]
                    scoreBoard[pass].rank = pass + 1
                    scoreBoard[currentPoistion] = tmp
                }
            }
            handler(scoreBoard)
        })
    }
    
    func fetchScoreOfUser(userName: String, scoreBoardId: String, handler: @escaping (Int?) -> Void) {
        databaseScoreBoardReference
            .child(scoreBoardId)
            .child(userName)
            .child("score")
            .observeSingleEvent(of: .value, with: { snapshot in
                guard let value = snapshot.value as? Int else {
                    handler(nil)
                    return
                }
                handler(value)
        })
    }
    
    func updateScoreToDatabase(name: String, score: Int, scoreBoardId: String) {
        databaseScoreBoardReference.child(scoreBoardId).child(name).child("score").setValue(score)
    }
}
