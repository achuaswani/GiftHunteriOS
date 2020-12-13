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
    case createQuizView
}

class ViewRouter: ObservableObject {
    @Published var currentPage: Page
    @Published var userName: String?
    @Published var nextPage: Page?
    @Published var quiz: Quiz?
    init(currentPage: Page,
         userName: String? = nil,
         nextPage: Page? = nil,
         quiz: Quiz? = nil) {
        self.currentPage = currentPage
        self.userName = userName
        self.nextPage = nextPage
        self.quiz = quiz
    }

}
