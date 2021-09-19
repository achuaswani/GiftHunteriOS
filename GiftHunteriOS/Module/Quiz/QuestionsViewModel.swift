//
//  QuestionsView.swift
//  GiftHunteriOS
//
//  Created by Aswani on 12/5/20.
//

import SwiftUI
import Combine
import Foundation

class QuestionsViewModel: ObservableObject {
    private var questionNumber: Int = 0
    private var questionId: String = ""
    private var previousQuestionId: String = ""
    private var pin: String = ""
    private var questions: [Question] = [Question.default]
    private var cancellable: AnyCancellable!
    private var score = 0
    private var timeRemaining: Int = AppConstants.MAXSECONDS

    @Published var timeRemainingText = ""
    @Published var shouldShowAlert = false
    @Published var question: Question = Question.default
    @Published var scoreText = "quiz.score.prefix".localized(with: "0")
    @Published var resultMessage = "result.info.message".localized()
    @Published var questionCounterText = "0/X"
    @Published var showToastMessage = false
    @Published var showProgressView = false
    @Published var toastMessage = ""
    @Published var progress: Float = 0
    
    var alertProvder = AlertProvider()
    
    @Published var viewRouter: ViewRouter
    @Published var quiz: Quiz?
    var userName: String  = ""

    var quizTitle: String {
        quiz?.title ?? ""
    }
    
    var quizDescription: String {
        quiz?.quizDetails ?? ""
    }
    
    private let firebaseDataService: FirebaseDataService
    private var dataService = QuizService()

    init(viewRouter: ViewRouter, firebaseDataService: FirebaseDataService) {
        self.viewRouter = viewRouter
        self.firebaseDataService = firebaseDataService
        self.viewRouter = viewRouter
        self.quiz = viewRouter.quiz
    }
    
    func updateData() {
        guard let name = firebaseDataService.profile?.userName else {
            return
        }
        userName = name
        updateScoreToBackend()
    }

    func fetchQuestions() {
        guard let quizId = quiz?.quizId else {
            return
        }
        showProgressView = true
        questions.removeAll()
        questionNumber = 0
        dataService.fetchQuestions(quizId: quizId) { [weak self] questions, error in
            guard let self = self else {
                return
            }
            guard error == nil, let questions = questions, !questions.isEmpty else {
                self.displayAlert()
                self.showProgressView = false
                return
            }
            self.questions = questions
            self.displayQuestion()
        }
    }
    
    func displayAlert() {
        async { [weak self] in
            self?.alertProvder.alert = AlertProvider.Alert(
                title: "alert.something.went.wrong.title".localized(),
                message: "alert.come.back.later.message".localized(),
                primaryButtonText: "general.got.it.button.title".localized(),
                primaryButtonAction: {
                    self?.shouldShowAlert = false
                },
                secondaryButtonText: "Cancel"
            )
            self?.shouldShowAlert = true
        }
    }


    func displayQuestion() {
        async { [weak self] in
            guard let self = self, self.questionNumber < self.questions.count else {
                return
            }
            self.resetTimer()
            self.questionCounterText = "\(self.questionNumber + 1)/\(self.questions.count)"
            self.question = self.questions[self.questionNumber]
            self.startTimer()
            self.showProgressView = false
        }
    }

    func submitAnswer(_ answer: Int) {
        showProgressView = true
        guard question.answer == String(answer) else {
            if let answerIndex = Int(question.answer) {
                let answerText = question.options[answerIndex]
                self.updateResultMessage(message: "wrong.answer.message".localized(with: answerText))
            }
            return
        }
        updateScore()
    }

    func updateScore() {
        let scoreAlgorithm = (timeRemaining * AppConstants.POINTSMULTIPLIER)
        score += scoreAlgorithm
        progress = Float(questionNumber) / Float(questions.count - 1)
        updateScoreToBackend()
        let scoreText = String(self.score)
        async { [weak self] in
            guard let self = self else {
                return
            }
            self.scoreText = "quiz.score.prefix".localized(with: scoreText)
            self.updateResultMessage(message: "correct.answer.message".localized())
        }
    }
    
    func updateScoreToBackend() {
        guard let id = quiz?.scoreBoardId else {
            fatalError("Username/scoreboardid not exists")
        }
        dataService.updateScoreToDatabase(name: userName, score: score, scoreBoardId: id)
    }

    func updateResultMessage(message: String) {
        async { [weak self] in
            guard let self = self else {
                return
            }
            self.resultMessage = message
            self.questionNumber += 1
            if self.questionNumber < self.questions.count {
                self.displayQuestion()
            } else {
                self.toastMessage = "quiz.completed.message".localized()
                self.showToastMessage = true
                self.stopTimer()
                self.routeToNextPage()
            }
        }
    }
    
    func routeToNextPage() {
        async { [weak self] in
            guard let self = self, let nextPage = self.viewRouter.nextPage else {
                return
            }
            self.viewRouter.scoreBoardId = self.quiz?.scoreBoardId
            self.viewRouter.currentPage = nextPage
        }
    }

    func startTimer() {
        cancellable = Timer.publish(every: 1, on: RunLoop.main, in: .default)
            .autoconnect()
            .sink(receiveValue: { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    self.remainingTimeInfo()
                } else if self.timeRemaining == 0 {
                    guard let answerIndex = Int(self.question.answer) else {
                        return
                    }
                    let answerText = self.question.options[answerIndex]
                    self.updateResultMessage(message: "time.up.message".localized(with: answerText))
                }
            })
    }

    func stopTimer() {
        async { [weak self] in
            guard let self = self else {
                return
            }
            self.resetTimer()
            self.remainingTimeInfo()
            self.showProgressView = false
        }
        cancellable?.cancel()
    }
    
    func resetTimer() {
        timeRemaining = AppConstants.MAXSECONDS
    }

    func remainingTimeInfo() {
        async { [weak self] in
            guard let self = self else {
                return
            }
            self.timeRemainingText = "remaining.time.info".localized(with: String(self.timeRemaining))
        }

    }

}
