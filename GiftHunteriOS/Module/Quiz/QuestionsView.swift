//
//  QuestionView.swift
//  GiftHunteriOS
//
//  Created by Aswani on 12/5/20.
//

import SwiftUI

struct QuestionsView: View {
    
    @StateObject var viewModel: QuestionsViewModel
    @EnvironmentObject var firebaseDataService: FirebaseDataService
    var body: some View {
            VStack(alignment: .center, spacing: 3.0) {
                Text(viewModel.question.questionText)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.all, BaseSize.generalSpacing)
                HStack {
                    ForEach(0..<2) { index in
                        showButtonView(index)
                        }
                    }
                .padding(.all, BaseSize.generalSpacing)
                
                HStack {
                    ForEach(2..<4) { index in
                        showButtonView(index)
                    }
                }
                .padding(.all, BaseSize.generalSpacing)
            }
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .shadow(color: Color.black.opacity(0.16), radius: 5, x: 0, y: 5)
            .padding(.all, BaseSize.outerSpacing)
            .overlay(Group {
                if viewModel.showProgressView {
                        ProgressView()
                    }
                })
            .onAppear {
                viewModel.updateData(firebaseDataService.profile?.userName)
            }
    }
    
    func showButtonView(_ index: Int) -> AnyView {
       return AnyView(
            Button(action: {
                viewModel.submitAnswer(index)
            }) {
                Text(viewModel.question.options[index])
                    .foregroundColor(Color("normalButton"))
                    .frame(width: 110, height: 50)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
            }
            .buttonStyle(BaseButtonStyle(color: .white))
            .padding(BaseSize.generalSpacing)
        )
    }

}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView(viewModel: QuestionsViewModel(viewRouter: ViewRouter(currentPage: .questionView, nextPage: .resultView)))
    }
}
