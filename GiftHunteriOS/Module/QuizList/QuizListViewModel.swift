//
//  QuizListViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/30/20.
//

import SwiftUI

class QuizListViewModel: ObservableObject {
    let headerTitle: String = "quiz.list.header.title".localized()
    let activeTitle: String = "quiz.list.publish.quiz.title".localized()
    let inactiveTitle: String = "quiz.list.unpublish.quiz.title".localized()
    let activeQuizDetails: String = "quiz.list.publish.button.title".localized()
    let inactiveQuizDetails: String = "quiz.list.unpublish.quiz.details".localized()
    let activateButtonTitle: String = "quiz.list.publish.button.title".localized()
    let inactivateButtonTitle: String = "quiz.list.unpublish.button.title".localized()
    let alertProvder = AlertProvider()
    var quizWithPIN: QuizWithPIN?
    @Published var inactiveQuiz = [QuizWithPIN]()
    @Published var activeQuiz = [QuizWithPIN]()
    @Published var showProgressView = false
    @Published var noQuizText = ""

    private let dataService = QuizService()
    var firebaseDataService: FirebaseDataService
    var viewRouter: ViewRouter

    init(viewRouter: ViewRouter, firebaseDataService: FirebaseDataService) {
        self.viewRouter = viewRouter
        self.firebaseDataService = firebaseDataService
    }
    
    func fetchAllQuizzes() {
        showProgressView = true
        let group = DispatchGroup()
        let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
        var inactiveQuizData = [QuizWithPIN]()
        var activeQuizData = [QuizWithPIN]()
        guard let profile = firebaseDataService.profile,
              let pinSet = profile.quizPIN,
              !pinSet.isEmpty else {
            debugPrint("No quiz available")
            showProgressView = false
            return
        }
        dispatchQueue.async { [weak self] in
            guard let self = self else {
                return
            }
            for pin in pinSet {
                group.enter()
                self.dataService.getInactiveQuiz(for: pin) { quizModel in
                    if let quizModel = quizModel {
                        let quizWithPIN = QuizWithPIN(pin: pin, quiz: quizModel)
                        inactiveQuizData.append(quizWithPIN)
                    } else {
                        group.enter()
                        self.dataService.getActiveQuiz(for: pin) { quizModel in
                            if let quizModel = quizModel {
                                let quizWithPIN = QuizWithPIN(pin: pin, quiz: quizModel)
                                activeQuizData.append(quizWithPIN)
                            }
                            group.leave()
                        }
                    }
                    group.leave()
                }
            }
            group.notify(queue: DispatchQueue.global()) {
                self.updateData(inactiveQuizData, activeQuizData)
            }
        }
    }
    
    func updateData(_ inactiveQuizData: [QuizWithPIN], _ activeQuizData: [QuizWithPIN]) {
        async { [weak self] in
            self?.inactiveQuiz = inactiveQuizData
            self?.activeQuiz = activeQuizData
            self?.showProgressView = false
            if inactiveQuizData.isEmpty, activeQuizData.isEmpty {
                self?.noQuizText = "quiz.list.no.results.text".localized()
            }
        }
    }
    
    func routeToNextPage(quizDetails: QuizWithPIN) {
        async { [weak self] in
            guard let self = self, let nextPage = self.viewRouter.nextPage else {
                return
            }
            self.viewRouter.pin = quizDetails.pin
            self.viewRouter.quiz = quizDetails.quiz
            self.viewRouter.nextPage = .questionsListView
            self.viewRouter.currentPage = nextPage
        }
    }
    
    func updateQuiz(_ quizDetails: QuizWithPIN, _ state: QuizState) {
        if state == .publish {
            dataService.activateQuiz(for: quizDetails) { [weak self] error in
                guard let self = self else {
                    return
                }
                guard let error = error else {
                    self.fetchAllQuizzes()
                    return
                }
                self.displayAlert(error.localizedDescription)
            }
        } else {
            dataService.inactivateQuiz(for: quizDetails) { [weak self] error in
                guard let self = self else {
                    return
                }
                guard let error = error else {
                    self.fetchAllQuizzes()
                    return
                }
                self.displayAlert(error.localizedDescription)
            }
        }
    }
    
    func updateQuizWithPIN(_ quizDetails: QuizWithPIN) {
        quizWithPIN = quizDetails
    }
    
    func resetQuizData() {
        quizWithPIN = nil
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
