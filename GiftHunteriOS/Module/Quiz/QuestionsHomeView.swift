//
//  QuestionsHomeView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/6/20.
//

import SwiftUI

struct QuestionsHomeView: View {
    @StateObject var viewModel: QuestionsViewModel = {
        QuestionsViewModel()
    }()
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Text("header")
                .padding(.horizontal, BaseSize.generalSpacing)
                .font(.system(size: 18, weight: .bold, design: .rounded))
            QuestionsView(viewModel: viewModel)
                .padding(.all, BaseSize.generalSpacing)

            Text(viewModel.questionCounterText)
                .padding(.all, BaseSize.generalSpacing)
                .font(.system(size: 14, weight: .bold, design: .rounded))
            Text(viewModel.scoreText)
                .padding(.all, BaseSize.generalSpacing)
                .font(.system(size: 14, weight: .bold, design: .rounded))
            Text(viewModel.resultMessage)
                .padding(.all, BaseSize.generalSpacing)
                .font(.system(size: 14, weight: .bold, design: .rounded))
            Text(viewModel.timeRemainingText)
                .padding(.all, BaseSize.generalSpacing)
                .font(.system(size: 14, weight: .bold, design: .rounded))
            
            
        }
        .onAppear {
            viewModel.fetchQuestions(quizId: "123")
        }
        .onDisappear {
            viewModel.stopTimer()
        }
        .alert(isPresented: $viewModel.shouldShowAlert ) {
            guard let alert = viewModel.alertProvder.alert else {
                fatalError("Alert not available")
            }
            return Alert(
                title: Text(alert.title).font(.system(size: 12, weight: .light, design: .rounded)),
                message: Text(alert.message).font(.system(size: 12, weight: .light, design: .rounded)),
                dismissButton: .default(Text(alert.primaryButtonText).font(.system(size: 12, weight: .light, design: .rounded)))
            )
        }
        .toast(isPresented: $viewModel.showToastMessage) {
            if viewModel.showToastMessage {
                async {
                    viewRouter.currentPage = .resultView
                }
            }
            return Text(viewModel.toastMessage)
        }
    }
}

struct QuestionsHomeView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsHomeView(viewRouter: ViewRouter())
    }
}
