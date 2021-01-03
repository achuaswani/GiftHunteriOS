//
//  CreateQuestionsView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/30/20.
//

import SwiftUI

struct CreateQuestionsView: View {
    @ObservedObject var viewModel: CreateQuestionsViewModel
    @ViewBuilder
    var body: some View {
        VStack {
            CloseButton()
                .padding([.leading, .top], 10)
                .onTapGesture {
                    
                }
            TextEditor(text: $viewModel.questionInput)
                .accessibility(identifier: "questionInput")
                .frame(minHeight: 30, alignment: .leading)
                .background(Color("normalTextField"))
                .cornerRadius(20.0)
                .shadow(radius: 5.0, x: 5, y: 5)
                .foregroundColor(viewModel.questionInput == viewModel.questionHintText ? .gray : .black)
                .padding(30)
                .onTapGesture {
                    viewModel.resetTextEditor()
                }
            
            HStack {
                ForEach(0..<2) { index in
                    option(index)
                }
            }
            HStack {
                ForEach(2..<4) { index in
                    option(index)
                }
            }
            Button(action: { viewModel.buttonAction() }) {
                Text(viewModel.addNextButtonTitle)
                    .frame(width: 300, height: 30)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
            }
            .buttonStyle(BaseButtonStyle())
            .accessibility(identifier: "button")
            .padding(10)
            .padding([.leading, .trailing], 27.5)
            .alert(isPresented: $viewModel.shouldShowAlert ) {
                guard let alert = viewModel.alertProvder.alert else {
                    fatalError("Alert not available")
                }
                return Alert(
                    title: Text(alert.title).font(.system(size: 12, weight: .light, design: .rounded)),
                    message: Text(alert.message).font(.system(size: 12, weight: .light, design: .rounded)),
                    dismissButton: .default(
                        Text(alert.primaryButtonText).font(.system(size: 12, weight: .light, design: .rounded)),
                        action: alert.primaryButtonAction
                    )
                )
            }
            .onAppear {
                viewModel.fetchQuestions()
            }
        }
    }
    
    func option(_ index: Int) -> some View {
        VStack {
            Button(action: { viewModel.correctAnswer = index}) {
                       Image(systemName: viewModel.correctAnswer == index ? "checkmark.circle.fill" : "circle.fill")
                   }
                
            TextField(viewModel.optionsHintText, text: $viewModel.options[index])
                .accessibility(identifier: "quizTitle")
                .padding()
                .background(Color("normalTextField"))
                .cornerRadius(20.0)
                .shadow(radius: 5.0, x: 5, y: 5)
                .padding(.bottom, 30)
        }
        .padding(5)
    }
}


struct CreateQuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        CreateQuestionsView(viewModel: CreateQuestionsViewModel(quiz: Quiz.default, firebaseDataService: FirebaseDataService()))
    }
}
