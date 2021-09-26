//
//  HomeRouterView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/6/20.
//

import SwiftUI

struct HomeRouterView: View {
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var firebaseDataService: FirebaseDataService
    
    var body: some View {
        switch viewRouter.currentPage {
        case .pinView:
            let viewModel = VerifyPINViewModel(viewRouter: viewRouter, firebaseDataService: firebaseDataService)
            VerifyPINView(viewModel: viewModel)
        case .questionView:
            let viewModel = QuestionsViewModel(viewRouter: viewRouter, firebaseDataService: firebaseDataService)
            QuestionsHomeView(viewModel: viewModel)
        case .resultView:
            let viewModel = QuizResultViewModel(viewRouter: viewRouter, firebaseDataService: firebaseDataService)
            QuizResultView(viewModel: viewModel)
        case .questionsListView:
            let viewModel = QuestionsListViewModel(viewRouter: viewRouter, firebaseDataService: firebaseDataService)
            QuestionsListView(viewModel: viewModel)
        case .quizListView:
            let viewModel = QuizListViewModel(viewRouter: viewRouter, firebaseDataService: firebaseDataService)
            QuizListView(viewModel: viewModel)
        case .userResultsView:
            let viewModel = UserResultsViewModel(viewRouter: viewRouter, firebaseDataService: firebaseDataService)
            UserResultsView(viewModel: viewModel)
        }
    }
}

struct HomeRouterView_Previews: PreviewProvider {
    static var previews: some View {
        let dataService = FirebaseDataService()
        dataService.profile = Profile.default
        return Group {
            HomeRouterView(viewRouter: ViewRouter(currentPage: .pinView, nextPage: .questionView))
            .environmentObject(dataService)
            .previewDevice("iPod touch (7th generation)")
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            
            HomeRouterView(viewRouter: ViewRouter(currentPage: .pinView, nextPage: .questionView))
            .environmentObject(dataService)
            .previewDevice("iPhone 12 Pro Max")
        }
    }
}
