//
//  ViewRouter.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/6/20.
//

import SwiftUI

enum Page {
    case pinView
    case resultView
    case questionView
    case questionsListView
    case quizListView
    case userResultsView
}

class ViewRouter: ObservableObject {
    @Published var currentPage: Page
    @Published var nextPage: Page?
    @Published var quiz: Quiz?
    @Published var pin: String?
    @Published var scoreBoardId: String?
    init(currentPage: Page,
         nextPage: Page? = nil,
         quiz: Quiz? = nil,
         pin: String? = nil,
         scoreBoardId: String? = nil) {
        self.currentPage = currentPage
        self.nextPage = nextPage
        self.quiz = quiz
        self.pin = pin
        self.scoreBoardId = scoreBoardId
    }

}
