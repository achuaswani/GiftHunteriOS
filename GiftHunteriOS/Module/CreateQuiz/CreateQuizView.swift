//
//  CreateQuizView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/12/20.
//

import SwiftUI

struct CreateQuizView: View {
    @ObservedObject var viewModel: CreateQuizViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                CloseButton()
                    .padding([.leading, .top], 1)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
                Text("Quiz Details")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(Color.black)
                    .padding([.leading, .top], 10)
                Spacer()
            }
            Divider()
            VStack {
                TextField(viewModel.quizPINHintText, text: $viewModel.quizPINInput)
                    .accessibility(identifier: "quizPIN")
                    .padding()
                    .background(Color("normalTextField"))
                    .cornerRadius(20.0)
                    .shadow(radius: 5.0, x: 5, y: 5)
                    .padding([.top, .bottom], 30)
                    .disabled(viewModel.isUpdateQuiz)
                    .foregroundColor(viewModel.isUpdateQuiz ? Color.gray : Color.black)
                TextField(viewModel.quizTitleHintText, text: $viewModel.quizTitleInput)
                    .accessibility(identifier: "quizTitle")
                    .padding()
                    .background(Color("normalTextField"))
                    .cornerRadius(20.0)
                    .shadow(radius: 5.0, x: 5, y: 5)
                    .padding(.bottom, 30)
                TextEditor(text: $viewModel.quizDetailsInput)
                    .accessibility(identifier: "quizDetails")
                    .frame(minHeight: 30, alignment: .leading)
                    .background(Color("normalTextField"))
                    .cornerRadius(20.0)
                    .shadow(radius: 5.0, x: 5, y: 5)
                    .foregroundColor(viewModel.quizDetailsInput == viewModel.quizDetailsHintText ? .gray : .black)
                    .padding(.bottom, 30)
                    .onTapGesture {
                        viewModel.resetTextEditor()
                    }
            }
        .padding([.leading, .trailing], 27.5)
        .navigationTitle(viewModel.headerTitle)
        Button(action: { viewModel.buttonAction() }) {
            Text(viewModel.startButtonTitle)
                .frame(width: 300, height: 30)
                .font(.system(size: 16, weight: .bold, design: .rounded))
        }
        .buttonStyle(BaseButtonStyle())
        .accessibility(identifier: "button")
        .padding(10)
        .padding([.leading, .trailing], 27.5)
        .alert(isPresented: $viewModel.shouldShowAlert) {
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
        .onReceive(viewModel.viewDismissalModePublisher) { shouldDismiss in
            if shouldDismiss {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        }
    }
}

struct CreateQuizView_Previews: PreviewProvider {
    static var previews: some View {
        CreateQuizView(
            viewModel: CreateQuizViewModel(
                quizWithPIN: QuizWithPIN.default,
                firebaseDataService: FirebaseDataService()
            )
        )
    }
}
