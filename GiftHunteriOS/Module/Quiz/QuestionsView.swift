//
//  QuestionView.swift
//  GiftHunteriOS
//
//  Created by Aswani on 12/5/20.
//

import SwiftUI

struct QuestionsView: View {
    
    @StateObject var viewModel: QuestionsViewModel
    var body: some View {
            VStack(alignment: .center, spacing: 3.0) {
                Text(viewModel.question.questionText)
                    .font(BaseStyle.normalFont)
                    .foregroundColor(.white)
                    .padding(.all, BaseStyle.generalSpacing)
                HStack {
                    ForEach(0..<2) { index in
                        showButtonView(index)
                        }
                    }
                .padding(.all, BaseStyle.generalSpacing)
                
                HStack {
                    ForEach(2..<4) { index in
                        showButtonView(index)
                    }
                }
                .padding(.all, BaseStyle.generalSpacing)
            }
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .shadow(color: Color.black.opacity(0.16), radius: 5, x: 0, y: 5)
            .padding(.all, BaseStyle.outerSpacing)
            .overlay(Group {
                if viewModel.showProgressView {
                    ProgressView()
                }
            })
            .onAppear {
                viewModel.updateData()
            }
    }
    
    func showButtonView(_ index: Int) -> AnyView {
       return AnyView(
            Button(action: {
                viewModel.submitAnswer(index)
            }) {
                Text(viewModel.question.options[index])
                    .foregroundColor(Color.accentColor)
                    .frame(width: 110, height: 50)
                    .font(BaseStyle.normalFont)
            }
            .buttonStyle(BaseButtonStyle(color: .white, halfScreen: true))
            .padding(BaseStyle.generalSpacing)
        )
    }

}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView(viewModel: QuestionsViewModel(viewRouter: ViewRouter(currentPage: .questionView, nextPage: .resultView), firebaseDataService: FirebaseDataService()))
    }
}
