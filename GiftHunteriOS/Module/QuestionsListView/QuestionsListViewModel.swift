//
//  QuestionsListViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 1/2/21.
//

import SwiftUI

class QuestionsListViewModel: ObservableObject {
    let headerTitle: String = "question.list.header.title".localized()
    @Published var questions = [Question]()
    @Published var noQuestionsText = ""
    @Published var showProgressView = false

    let alertProvder = AlertProvider()
    private let dataService = QuizService()
    var firebaseDataService: FirebaseDataService
    var viewRouter: ViewRouter
    var quizId: String
    var questionIndex: Int?
    init(viewRouter: ViewRouter, firebaseDataService: FirebaseDataService) {
        self.viewRouter = viewRouter
        self.firebaseDataService = firebaseDataService
        self.quizId = viewRouter.quiz?.quizId ?? ""
    }
    
    func fetchQuestions() {
        showProgressView = true
        questionIndex = nil
        questions.removeAll()
        dataService.fetchQuestions(quizId: quizId) { [weak self] questions, error in
            guard let self = self else {
                return
            }
            self.showProgressView = false
            guard error == nil, let questions = questions, !questions.isEmpty else {
                self.noQuestionsText = "question.list.no.results.text".localized()
                return
            }
            self.questions = questions
        }
    }
    
    func updateQuiz(_ question: Question) {
        dataService.updateQuestion(quizId: quizId, questions: questions) { [weak self] error in
            guard let self = self else {
                return
            }
            guard let error = error else {
                self.fetchQuestions()
                return
            }
            self.displayAlert(error.localizedDescription)
        }
    }
    
    func updateQuestions(_ index: Int, _ question: Question) {
        questions[index] = question
        questionIndex = index
    }
    
    func displayAlert(_ message: String) {
        async { [weak self] in
            self?.alertProvder.alert = AlertProvider.Alert(
                title: "alert.something.went.wrong.title".localized(),
                message: message,
                primaryButtonText: "general.got.it.button.title".localized(),
                primaryButtonAction: {
                },
                secondaryButtonText: nil
            )
        }
    }
}
