//
//  CreateQuestionsViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/30/20.
//

import SwiftUI

class CreateQuestionsViewModel: ObservableObject {
    let questionHintText = "create.question.enter.question.text".localized()
    let optionsHintText = "create.question.enter.option.text".localized()
    var addNextButtonTitle = "create.question.add.next.button.title".localized()
    var questions = [Question]()
    @Published var questionInput: String = "create.question.enter.question.text".localized()
    @Published var options: [String] = [String](repeating: "", count: 4)
    @Published var correctAnswer: Int = 0
    @Published var shouldShowAlert = false
    let alertProvder = AlertProvider()
    private let dataService = QuizService()
    var quiz: Quiz
    private var firebaseDataService: FirebaseDataService
    init(quiz: Quiz, firebaseDataService: FirebaseDataService) {
        self.quiz = quiz
        self.firebaseDataService = firebaseDataService
    }
    
    func resetTextEditor() {
        if questionInput  == questionHintText {
            questionInput = ""
        }
    }
    
    func fetchQuestions() {
        questions.removeAll()
        //questionNumber = 0
        dataService.fetchQuestions(quizId: quiz.quizId) { [weak self] questions, error in
            guard let self = self else {
                return
            }
            guard error == nil, let questions = questions, !questions.isEmpty else {
                return
            }
            self.questions = questions
        }
    }
    
    func buttonAction() {
        let question = Question(
            id: quiz.quizId,
            questionText: questionInput,
            answer: String(correctAnswer),
            options: options,
            media: ""
        )
        questions.append(question)
        dataService.updateQuestion(quizId: quiz.quizId, questions: questions) { [weak self] error in
            guard let error = error else {
                self?.resetUI()
                return
            }
            self?.displayAlert(error.localizedDescription)
        }
    }
    
    func resetUI() {
        async { [weak self] in
            self?.questionInput = "create.question.enter.question.text".localized()
            self?.options = [String](repeating: "", count: 4)
            self?.correctAnswer = 0
        }
    }
    
    func displayAlert(_ message: String) {
        async { [weak self] in
            self?.alertProvder.alert = AlertProvider.Alert(
                title: "general.alert.title".localized(),
                message: message,
                primaryButtonText: "general.got.it.button.title".localized(),
                primaryButtonAction: {
                    self?.shouldShowAlert = false
                },
                secondaryButtonText: nil
            )
            self?.shouldShowAlert = true
        }
    }
}
