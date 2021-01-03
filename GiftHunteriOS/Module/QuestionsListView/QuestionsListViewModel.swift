//
//  QuestionsListViewModel.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 1/2/21.
//

import SwiftUI

class QuestionsListViewModel: ObservableObject {
    private let dataService = QuizService()
    var firebaseDataService: FirebaseDataService
    var viewRouter: ViewRouter

    init(viewRouter: ViewRouter, firebaseDataService: FirebaseDataService) {
        self.viewRouter = viewRouter
        self.firebaseDataService = firebaseDataService
    }
}
