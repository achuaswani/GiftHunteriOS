//
//  HomeRouterView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/6/20.
//

import SwiftUI

struct HomeRouterView: View {
    @StateObject var viewRouter: ViewRouter
    var view: Page
    var body: some View {
        switch viewRouter.currentPage {
        case .pinView:
            let viewModel = VerifyPINViewModel(viewRouter: viewRouter, page: view)
            VerifyPINView(viewModel: viewModel)
        case .questionView:
            QuestionsHomeView(viewRouter: viewRouter)
        case .resultView:
            QuizResultView()
        }
    }
}

struct HomeRouterView_Previews: PreviewProvider {
    static var previews: some View {
        HomeRouterView(viewRouter: ViewRouter(), view: .questionView)
    }
}
