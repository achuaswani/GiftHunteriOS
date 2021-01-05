//
//  VerifyPINViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/10/20.
//

import SwiftUI

class VerifyPINViewModel: ObservableObject {
    var hinText: String = "quiz.pin.enter.hint.text.title".localized()
    var buttonText: String = "general.submit.button.title".localized()
    
    @Published var quiz: Quiz?
    @Published var shouldShowAlert = false
    let alertProvder = AlertProvider()
    @Published var viewRouter: ViewRouter
    private var firebaseDataService: FirebaseDataService
    private let dataService = QuizService()

    init(viewRouter: ViewRouter, firebaseDataService: FirebaseDataService) {
        self.viewRouter = viewRouter
        self.firebaseDataService = firebaseDataService
    }
    
    func verifyPIN(_ pin: String) {
        guard !pin.isEmpty else {
            displayAlert("alert.missing.pin.message".localized())
            return
        }
        guard var profile = firebaseDataService.profile else {
            return
        }
        var quizPINSet = profile.quizPIN
        if quizPINSet?.contains(pin) ?? false {
            displayAlert("alert.already.exists.pin.your.list".localized())
            return
        }
        
        if quizPINSet != nil {
            quizPINSet!.append(pin)
        } else {
            quizPINSet = [pin]
        }
        profile.quizPIN = quizPINSet
        viewRouter.pin = pin
        dataService.getActiveQuiz(for: pin) { [weak self] quizModel in
            guard  let self = self else {
                return
            }
            if let quizModel = quizModel {
                self.viewRouter.quiz = quizModel
                self.firebaseDataService.updateProfile(userValue: profile) { error in
                    self.routeToNextPage()
                }
            } else {
                self.displayAlert("alert.no.quiz.available.message".localized())
            }
        }
    }
    
    func routeToNextPage() {
        guard let nextPage = self.viewRouter.nextPage else {
            return
        }
        self.viewRouter.nextPage = .resultView
        self.viewRouter.currentPage = nextPage
    }
    
    func displayAlert(_ message: String) {
        async { [weak self] in
            self?.alertProvder.alert = AlertProvider.Alert(
                title: "alert.enter.valid.pin.title".localized(),
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
