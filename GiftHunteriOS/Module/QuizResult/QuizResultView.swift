//
//  QuizResultView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/5/20.
//

import SwiftUI

struct QuizResultView: View {
    @StateObject var viewModel: QuizResultViewModel
    var body: some View {
        VStack {
            Text(viewModel.quizTitle)
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .foregroundColor(Color("normalFontColor"))
                .multilineTextAlignment(.center)
            Text(viewModel.quizDetails)
                .font(.system(size: 18, weight: .light, design: .rounded))
                .foregroundColor(Color("normalFontColor"))
                .multilineTextAlignment(.center)
            ScrollView(.vertical, showsIndicators: false) {
                cardView
            }
            .onAppear {
                viewModel.fetchScoreBoard()
            }
        }
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea([.leading, .trailing])
        .background(Color("backgroundColor"))
        .navigationBarTitle(viewModel.headerTitle, displayMode: .inline)
        .overlay(Group {
            if viewModel.showProgressView {
                    ProgressView()
                }
            }
        )
    }
    
    var cardView: some View {
        VStack {
            ForEach(viewModel.scoreBoard, id: \.self) { scoreBoard in
                VStack {
                    if scoreBoard.rank == 1 {
                        Image("winner")
                            .resizable()
                            .frame(width: 80, height: 50)
                    }
                    VStack {
                        Text(scoreBoard.name)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(Color("normalFontColor"))
                        Text(String("\("scoreboard.score.title".localized()) \(scoreBoard.score)"))
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color("normalFontColor"))
                        Text(String("\("scoreboard.rank.title".localized()) \(scoreBoard.rank)"))
                            .font(.system(size: 16, weight: .light, design: .rounded))
                            .foregroundColor(Color("normalFontColor"))
                    }
                }
                .frame(width: 300.0, height: 100)
                .padding(.all, 25)
                .background(Color("cellColor"))
                .shadow(color: Color.black.opacity(0.16), radius: 5, x: 0, y: 5)
            }
            .contentShape(Rectangle())
        }
    }
}

struct QuizResultView_Previews: PreviewProvider {
    static var previews: some View {
        let viewRouter = ViewRouter(currentPage: .resultView)
        QuizResultView(viewModel: QuizResultViewModel(viewRouter: viewRouter, firebaseDataService: FirebaseDataService()))
    }
}
