//
//  HomeRouterView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/6/20.
//

import SwiftUI

struct HomeRouterView: View {
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
        case .pinView:
            let viewModel = VerifyPINViewModel(viewRouter: viewRouter)
            VerifyPINView(viewModel: viewModel)
        case .questionView:
            let viewModel = QuestionsViewModel(viewRouter: viewRouter)
            QuestionsHomeView(viewModel: viewModel)
        case .resultView:
            let viewModel = QuizResultViewModel(viewRouter: viewRouter)
            QuizResultView(viewModel: viewModel)
        case .createQuizView:
            let viewModel = CreateQuizViewModel(viewRouter: viewRouter)
            CreateQuizView(viewModel: viewModel)
        }
    }
}

struct HomeRouterView_Previews: PreviewProvider {
    static var previews: some View {
        HomeRouterView(viewRouter: ViewRouter(currentPage: .pinView, nextPage: .questionView))
    }
}
