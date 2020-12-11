//
//  VerifyPINViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/10/20.
//

import SwiftUI

class VerifyPINViewModel: ObservableObject {
    var hinText = "quiz.pin.enter.hint.text.title".localized()
    var buttonText = "general.submit.button.title".localized()
    @Published var quiz: Quiz?
    @Published var shouldShowAlert = false
    var dataService = FirebaseDataService()
    var alertProvder = AlertProvider()
    
    @Published var viewRouter: ViewRouter
    var page: Page

    init(viewRouter: ViewRouter, page: Page) {
        self.viewRouter = viewRouter
        self.page = page
    }
    
    func verifyPIN(pin: String) {
        dataService.verifyQuizPIN(pin: pin) { [weak self] quizModel in
            guard let quizModel = quizModel, let selfclass = self else {
                self?.displayAlert()
                return
            }
            selfclass.quiz = quizModel
            selfclass.viewRouter.currentPage = selfclass.page
        }
    }
    
    func displayAlert() {
        async { [weak self] in
            self?.alertProvder.alert = AlertProvider.Alert(
                title: "alert.quiz.pin.incorrect.title".localized(),
                message: "alert.no.quiz.available.message".localized(),
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
