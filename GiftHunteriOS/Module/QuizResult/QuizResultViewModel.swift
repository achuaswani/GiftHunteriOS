//
//  QuizResultViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/5/20.
//

import SwiftUI

class QuizResultViewModel: ObservableObject {
    @Published var scoreBoard = [ScoreBoard]()
    @Published var showProgressView = false
    var viewRouter: ViewRouter
    let headerTitle: String = "scoreboard.header.title".localized()
    var quizTitle: String = ""
    var quizDetails: String = ""
    private let firebaseDataService: FirebaseDataService
    private let dataService = QuizService()

    init(viewRouter: ViewRouter, firebaseDataService: FirebaseDataService) {
        self.viewRouter = viewRouter
        self.firebaseDataService = firebaseDataService
        if let quiz = viewRouter.quiz {
            self.quizTitle = quiz.title
            self.quizDetails = quiz.quizDetails
        }
    }
    
    func fetchScoreBoard() {
        showProgressView = true
        guard let scoreBoardId = viewRouter.scoreBoardId else {
            return
        }
        dataService.fetchScoreBoard(scoreBoardId: scoreBoardId) { [weak self] scoreBoardReponse in
            self?.showProgressView = false
            guard let scoreBoardReponse = scoreBoardReponse else {
                return
            }
            self?.scoreBoard = scoreBoardReponse
        }
    }
}
