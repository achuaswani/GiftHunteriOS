//
//  QuizResultViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/5/20.
//

import SwiftUI

class QuizResultViewModel: ObservableObject {
    @Published var scoreBoard = [ScoreBoard.default]
    var viewRouter: ViewRouter
    var dataService = FirebaseDataService()
    
    var headerTitle: String = "scoreboard.header.title".localized()
    var quizTitle: String = ""
    var quizDetails: String = ""
    init(viewRouter: ViewRouter) {
        self.viewRouter = viewRouter
        if let quiz = viewRouter.quiz {
            self.quizTitle = quiz.title
            self.quizDetails = quiz.quizDetails
        }
    }
    
    func fetchScoreBoard() {
        guard let scoreBoardId = viewRouter.quiz?.scoreBoardId else {
            return
        }
        dataService.fetchScoreBoard(scoreBoardId: scoreBoardId) { [weak self] scoreBoardReponse in
            guard let scoreBoardReponse = scoreBoardReponse else {
                return
            }
            self?.scoreBoard = scoreBoardReponse
        }
    }
}
