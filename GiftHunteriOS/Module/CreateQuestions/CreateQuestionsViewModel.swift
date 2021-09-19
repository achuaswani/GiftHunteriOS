//
//  CreateQuestionsViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/30/20.
//

import SwiftUI
import Combine

class CreateQuestionsViewModel: ObservableObject {
    let questionHintText = "create.question.enter.question.text".localized()
    let optionsHintText = "create.question.enter.option.text".localized()
    var addButtonTitle = "create.question.add.button.title".localized()
    var headerTitle = "create.quiz.header.title".localized()
    var questions: [Question]
    @Published var questionInput: String = "create.question.enter.question.text".localized()
    @Published var options: [String] = [String](repeating: "", count: 4)
    @Published var correctAnswer: Int = 0
    @Published var shouldShowAlert = false
    let alertProvder = AlertProvider()
    private let dataService = QuizService()
    var questionIndex: Int?
    var quizId: String
    private var firebaseDataService: FirebaseDataService
    init(quizId: String, questions: [Question], questionIndex: Int?, firebaseDataService: FirebaseDataService) {
        self.quizId =  quizId
        self.questions = questions
        self.firebaseDataService = firebaseDataService
        if let questionIndex = questionIndex {
            self.questionIndex = questionIndex
            questionInput = questions[questionIndex].questionText
            options = questions[questionIndex].options
            correctAnswer = Int(questions[questionIndex].answer) ?? 0
            addButtonTitle = "create.question.update.button.title".localized()
        }
    }
    
    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
    private var shouldDismissView = false {
        didSet {
            viewDismissalModePublisher.send(shouldDismissView)
        }
    }
    deinit {
            print("class being deinitialized")
    }
    func resetTextEditor() {
        if questionInput  == questionHintText {
            questionInput = ""
        }
    }
    
    func buttonAction() {
        if let questionIndex = questionIndex {
            var question = questions[questionIndex]
            question.questionText = questionInput
            question.answer = String(correctAnswer)
            question.options = options
            questions[questionIndex] = question
        } else {
            let question = Question(
                questionText: questionInput,
                answer: String(correctAnswer),
                options: options,
                media: ""
            )
            questions.append(question)
        }
        dataService.updateQuestion(quizId: quizId, questions: questions) { [weak self] error in
            guard let error = error else {
                self?.closePresenter()
                return
            }
            self?.displayAlert(error.localizedDescription)
        }
    }
    
    func closePresenter() {
        async { [weak self] in
            self?.shouldDismissView = true
        }
    }
    
    func deleteQuiz() {
        guard let questionIndex = questionIndex else {
            return
        }
        questions.remove(at: questionIndex)
        dataService.updateQuestion(quizId: quizId, questions: questions) { [weak self] error in
            guard let error = error else {
                self?.closePresenter()
                return
            }
            self?.displayAlert(error.localizedDescription)
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
