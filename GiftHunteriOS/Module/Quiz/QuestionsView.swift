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
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.all, BaseSize.generalSpacing)
                HStack {
                    ForEach(0..<2) { index in
                        showButtonView(index)
                        }
                    }
                .padding(.all, BaseSize.generalSpacing)
                if viewModel.showProgressView {
                    ProgressView()
                }
                HStack {
                    ForEach(2..<4) { index in
                        showButtonView(index)
                    }
                }
                .padding(.all, BaseSize.generalSpacing)
        }
        .background(Color.accentColor)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: Color.blue, radius: 20, x: 0, y: 10)
        .padding(.all, BaseSize.outerSpacing)
    }
    
    func showButtonView(_ index: Int) -> AnyView {
       return AnyView(
            Button(action: {
                viewModel.submitAnswer(index)
            }) {
                Text(viewModel.question.options[index])
                    .foregroundColor(.normalButton)
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
        QuestionsView(viewModel: QuestionsViewModel())
    }
}
