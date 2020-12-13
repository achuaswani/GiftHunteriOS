//
//  HomeViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/11/20.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var viewList = [
        ViewList(viewName: .questionView, buttonTitle: "quiz.start".localized(), imageName: "quiz"),
        ViewList(viewName: .resultView, buttonTitle: "quiz.view.results".localized(), imageName: "results"),
        ViewList(viewName: .createQuizView, buttonTitle: "quiz.view.create.quiz".localized(), imageName: "createQuiz")
    ]
}
