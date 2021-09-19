//
//  CreateQuizViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/12/20.
//

import SwiftUI
import Combine

class CreateQuizViewModel: ObservableObject {
    let headerTitle = "create.quiz.header.title".localized()
    let quizTitleHintText = "create.quiz.enter.title.hint.text".localized()
    let quizPINHintText = "create.quiz.enter.quiz.pin.hint.text".localized()
    let quizDetailsHintText = "create.quiz.enter.quiz.details.text".localized()
    var startButtonTitle = "create.quiz.create.button.title".localized()
    var isUpdateQuiz = false
    @Published var quizTitleInput: String = ""
    @Published var quizPINInput: String = ""
    @Published var quizDetailsInput: String = "create.quiz.enter.quiz.details.text".localized()
    @Published var shouldShowAlert = false
    private let dataService = QuizService()
    let alertProvder = AlertProvider()
    var quizWithPIN: QuizWithPIN?
    private var firebaseDataService: FirebaseDataService

    init(quizWithPIN: QuizWithPIN?, firebaseDataService: FirebaseDataService) {
        self.quizWithPIN = quizWithPIN
        self.firebaseDataService = firebaseDataService
       
        if let quizWithPIN  = self.quizWithPIN {
            quizPINInput = quizWithPIN.pin
            isUpdateQuiz = true
            quizTitleInput = quizWithPIN.quiz.title
            quizDetailsInput = quizWithPIN.quiz.quizDetails
            startButtonTitle = "update.quiz.start.button.title".localized()
        }
    }
    deinit {
            print("class being deinitialized")
    }
    
    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
    private var shouldDismissView = false {
        didSet {
            viewDismissalModePublisher.send(shouldDismissView)
        }
    }
        
    func resetTextEditor() {
        if quizDetailsInput  == quizDetailsHintText {
            quizDetailsInput = ""
        }
    }
    
    func buttonTapped() {
        guard !quizPINInput.isEmpty else {
            displayAlert("alert.missing.pin.message".localized())
            return
        }
        guard let userid = firebaseDataService.profile?.userId else {
            fatalError("User not exists")
        }
        
        
        if self.isUpdateQuiz, var quiz = quizWithPIN?.quiz {
            quiz.title = quizTitleInput
            quiz.quizDetails = quizDetailsInput
            self.updateQuiz(for: self.quizPINInput, quiz: quiz)
            return
        }
        
        if firebaseDataService.profile?.quizPIN?.contains(quizPINInput) ?? false {
            displayAlert("alert.already.exists.pin.your.list".localized())
            return
        }
        
        dataService.checkIfPINExists(quizPINInput) { [weak self] isExists in
            guard  let self = self else {
                return
            }
            
            if isExists {
                self.displayAlert("alert.quiz.already.available.message".localized())
            } else {
                let quiz = Quiz(
                    quizId: ShortCodeGenerator.getCode(length: 6),
                    title: self.quizTitleInput,
                    quizDetails: self.quizDetailsInput,
                    scoreBoardId: ShortCodeGenerator.getCode(length: 6),
                    hostId: userid
                )
                self.updateQuiz(for: self.quizPINInput, quiz: quiz)
            }
        }
    }
    
    func updateQuiz(for pin: String, quiz: Quiz) {
        dataService.updateQuiz(pin: pin, quiz: quiz) { [weak self] error in
            guard let self = self else {
                return
            }
            if let error = error {
                self.displayAlert(error.localizedDescription)
            } else {
                if !self.isUpdateQuiz, var profile = self.firebaseDataService.profile {
                    let pin = self.quizPINInput
                    var quizPINSet = profile.quizPIN
                    if quizPINSet != nil {
                        quizPINSet!.append(pin)
                    } else {
                        quizPINSet = [pin]
                    }
                    profile.quizPIN = quizPINSet
                    self.updateProfileData(profile)
                } else {
                    self.shouldDismissView = true
                }
            }
        }
    }
    
    func updateProfileData(_ profile: Profile) {
        firebaseDataService.updateProfile(userValue: profile) { error in
            if let error = error {
                self.displayAlert(error.localizedDescription)
            } else {
                self.shouldDismissView = true
            }
        }
    }
    
    func deleteQuiz() {
        guard let pin = quizWithPIN?.pin,
              var profile = firebaseDataService.profile else {
            return
        }
        self.dataService.deleteQuiz(for: pin) { [weak self] error in
            guard let self = self else {
                return
            }
            if let error = error {
                self.displayAlert(error.localizedDescription)
                return
            }
            let quizPINSet = profile.quizPIN?.filter { $0 != pin }
            profile.quizPIN = quizPINSet
            self.updateProfileData(profile)
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
