//
//  QuestionsHomeView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/6/20.
//

import SwiftUI

struct QuestionsHomeView: View {
    @StateObject var viewModel: QuestionsViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.quizTitle)
                .padding(.horizontal, BaseSize.generalSpacing)
                .font(.system(size: 18, weight: .bold, design: .rounded))
            Text(viewModel.quizDescription)
                .padding(.horizontal, BaseSize.generalSpacing)
                .font(.system(size: 16, weight: .bold, design: .rounded))
            QuestionsView(viewModel: viewModel)
                .padding(.all, BaseSize.generalSpacing)

            Text(viewModel.questionCounterText)
                .padding(.all, BaseSize.generalSpacing)
                .font(.system(size: 14, weight: .bold, design: .rounded))
            //ProgressView(value: viewModel.progress)
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
            viewModel.fetchQuestions()
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
            return Text(viewModel.toastMessage)
        }
    }
}

struct QuestionsHomeView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsHomeView(viewModel: QuestionsViewModel(viewRouter: ViewRouter(currentPage: .questionView, nextPage: .resultView), firebaseDataService: FirebaseDataService()))
    }
}
