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
        case .questionView:
            QuestionsHomeView(viewRouter: viewRouter)
        case .resultView:
            QuizResultView()
        }
    }
}

struct HomeRouterView_Previews: PreviewProvider {
    static var previews: some View {
        HomeRouterView(viewRouter: ViewRouter())
    }
}
