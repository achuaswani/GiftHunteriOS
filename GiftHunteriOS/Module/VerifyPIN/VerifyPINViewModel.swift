//
//  VerifyPINViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/10/20.
//

import SwiftUI

class VerifyPINViewModel: ObservableObject {
    var hinText: String {
        switch viewRouter.nextPage {
        case .createQuizView:
            return "quiz.pin.creater.hint.text.title".localized()
        default:
            return "quiz.pin.enter.hint.text.title".localized()
        }
    }
    var buttonText: String {
        switch viewRouter.nextPage {
        case.createQuizView:
            return "general.create.button.title".localized()
        default:
            return "general.submit.button.title".localized()
        }
    }
    @Published var quiz: Quiz?
    @Published var shouldShowAlert = false
    var dataService = QuizService()
    var alertProvder = AlertProvider()
    @Published var viewRouter: ViewRouter
    var firebaseDataService: FirebaseDataService?

    init(viewRouter: ViewRouter) {
        self.viewRouter = viewRouter
    }
    
    func verifyPIN(_ pin: String, firebaseDataService: FirebaseDataService) {
        guard !pin.isEmpty else {
            displayAlert("alert.missing.pin.message".localized())
            return
        }
        
        if firebaseDataService.profile?.quizPIN?.contains(pin) ?? false {
            displayAlert("alert.already.exists.pin.your.list".localized())
            return
        }
        viewRouter.pin = pin
        
        dataService.verifyQuizPIN(pin: pin) { [weak self] quizModel in
            guard  let self = self else {
                return
            }
            if let quizModel = quizModel {
                self.viewRouter.quiz = quizModel
                if firebaseDataService.profile?.quizPIN == nil {
                    firebaseDataService.profile?.quizPIN = [pin]
                } else {
                    firebaseDataService.profile?.quizPIN?.append(pin)
                }
                if let profile = firebaseDataService.profile {
                    firebaseDataService.updateProfile(userValue: profile) { error in
                        self.routeToNextPage()
                    }
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
