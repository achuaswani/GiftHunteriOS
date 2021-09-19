//
//  HomeViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/11/20.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let userViewList = [
        ViewList(
            currentPage: .pinView,
            nextPage: .questionView,
            buttonTitle: "quiz.start.button.title".localized(),
            imageName: "quiz"
        ),
        ViewList(
            currentPage: .userResultsView,
            nextPage: .resultView,
            buttonTitle: "quiz.results.button.title".localized(),
            imageName: "results"
        )
    ]
    
    let adminViewList = [
        ViewList(
            currentPage: .quizListView,
            nextPage: .questionsListView,
            buttonTitle: "quiz.view.active.button.title".localized(),
            imageName: "createQuiz"
        ),
        ViewList(
            currentPage: .userResultsView,
            nextPage: .resultView,
            buttonTitle: "quiz.results.button.title".localized(),
            imageName: "results"
        )
    ]
}
