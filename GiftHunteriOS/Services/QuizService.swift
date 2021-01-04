//
//  QuizService.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/16/20.
//

import FirebaseDatabase
import CodableFirebase

class QuizService {
    var databaseActiveQuizReference = Database.database().reference().child(AppConstants.NODEACTIVEQUIZ)
    var databaseInactiveQuizReference = Database.database().reference().child(AppConstants.NODEINACTIVEQUIZ)
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
    func checkIfPINExists(_ pin: String, handler: @escaping (Bool) -> Void) {
        databaseActiveQuizReference.observeSingleEvent(of: .value, with: { snapshot in
            let snapshot = snapshot.childSnapshot(forPath: pin)
            guard snapshot.exists() else {
                handler(false)
                return
            }
            self.databaseInactiveQuizReference.observeSingleEvent(of: .value, with: { inactiveSnapshot in
                let inactiveSnapshot = inactiveSnapshot.childSnapshot(forPath: pin)
                guard inactiveSnapshot.exists() else {
                    handler(false)
                    return
                }
                handler(true)
            })
        })
    }
    
    // MARK: - Get Active Quiz
    func getActiveQuiz(for pin: String, handler: @escaping (Quiz?) -> Void) {
        databaseActiveQuizReference.observeSingleEvent(of: .value, with: { snapshot in
            let snapshot = snapshot.childSnapshot(forPath: pin)
            guard snapshot.exists(), let value = snapshot.value else {
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
    
    // MARK: - Get Inactive Quiz
    func getInactiveQuiz(for pin: String, handler: @escaping (Quiz?) -> Void) {
        databaseInactiveQuizReference.observeSingleEvent(of: .value, with: { snapshot in
            let snapshot = snapshot.childSnapshot(forPath: pin)
            guard snapshot.exists(), let value = snapshot.value else {
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
    
    // MARK: - Move Active quiz to Inactive state
    func inactivateQuiz(for quizDetails: QuizWithPIN, handler:  @escaping(Error?) -> Void) {
        databaseInactiveQuizReference.child(quizDetails.pin).setValue(quizDetails.quiz.getQuizDictionary()) { (error: Error?, ref: DatabaseReference) in
            if error == nil {
                self.databaseActiveQuizReference.child(quizDetails.pin).removeValue()
            }
            handler(error)
        }
    }
    
    // MARK: - Move Inactive quiz to Active state
    func activateQuiz(for quizDetails: QuizWithPIN, handler:  @escaping(Error?) -> Void) {
        databaseActiveQuizReference.child(quizDetails.pin).setValue(quizDetails.quiz.getQuizDictionary()) { (error: Error?, ref: DatabaseReference) in
            if error == nil {
                self.databaseInactiveQuizReference.child(quizDetails.pin).removeValue()
            }
            handler(error)
    
        }
    }
    
    // MARK: - Create New Quiz
    
    func updateQuiz(pin: String, quiz: Quiz, handler:  @escaping(Error?) -> Void) {
        databaseInactiveQuizReference.child(pin).setValue(quiz.getQuizDictionary()) { (error: Error?, ref: DatabaseReference) in
           handler(error)
        }
    }
    
    // MARK: - Delete quiz
    
    func deleteQuiz(for pin: String, handler:  @escaping(Error?) -> Void) {
        databaseInactiveQuizReference.child(pin).removeValue { (error: Error?, ref: DatabaseReference) in
           handler(error)
        }
    }
    
    // MARK: - Create new Question
    
    func updateQuestion(quizId: String, questions: [Question], handler:  @escaping(Error?) -> Void) {
        var questionsDictionaryArray = [[String: Any]]()
        for question in questions {
            questionsDictionaryArray.append(question.getQuizDictionary())
        }
        databaseQuestinsReference.child(quizId).setValue(questionsDictionaryArray) { (error: Error?, ref: DatabaseReference) in
           handler(error)
        }
    }
    
    // MARK: - Fetch Scoreboard
    
    func fetchScoreBoard(scoreBoardId: String, handler: @escaping ([ScoreBoard]?) -> Void) {
        databaseScoreBoardReference.child(scoreBoardId).observe(.value, with: { snapshot in
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
            scoreBoard = self.quicksort(scoreBoard)
            var rank = 1
            scoreBoard[0].rank = rank
            for pass in 1..<scoreBoard.count {
                if scoreBoard[pass].score != scoreBoard[pass-1].score {
                    rank += 1
                }
                scoreBoard[pass].rank = rank
            }
            handler(scoreBoard)
        })
    }
    
    private func quicksort(_ a: [ScoreBoard]) -> [ScoreBoard] {
        guard a.count > 1 else { return a }
        let pivot = a[a.count/2].score
        let less = a.filter { $0.score > pivot }
        let equal = a.filter { $0.score == pivot }
        let greater = a.filter { $0.score < pivot }
        return quicksort(less) + equal + quicksort(greater)
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
    
    // MARK: - Update score
    func updateScoreToDatabase(name: String, score: Int, scoreBoardId: String) {
        databaseScoreBoardReference.child(scoreBoardId).child(name).child("score").setValue(score)
    }
}
