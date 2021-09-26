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
    
    init(viewModel: CreateQuizViewModel) {
        UITextView.appearance().backgroundColor = .clear
        self.viewModel = viewModel
    }
    @ViewBuilder
    var body: some View {
        VStack {
            HStack {
                CloseButton()
                    .padding(.leading, 5)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
                Text(viewModel.headerTitle)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(Color("fontColor"))
                    .padding([.leading, .top], 20)
                Spacer()
                if viewModel.isUpdateQuiz {
                    Image(systemName: "trash.circle.fill")
                        .resizable()
                        .foregroundColor(.red)
                        .frame(width: 30, height: 30)
                        .padding()
                        .onTapGesture {
                            viewModel.deleteQuiz()
                        }
                }
            }
            Divider()
           // VStack {
                TextField(viewModel.quizPINHintText, text: $viewModel.quizPINInput)
                    .accessibility(identifier: "quizPIN")
                    .padding()
                    .background(Color("normalTextField"))
                    .font(.system(size: 14, weight: .light, design: .rounded))
                    .cornerRadius(20.0)
                    .shadow(radius: 5.0, x: 5, y: 5)
                    .padding(30)
                    .disabled(viewModel.isUpdateQuiz)
                    .foregroundColor(viewModel.isUpdateQuiz ? Color("disableFontColor") : Color("fontColor"))
                TextField(viewModel.quizTitleHintText, text: $viewModel.quizTitleInput)
                    .accessibility(identifier: "quizTitle")
                    .padding()
                    .background(Color("normalTextField"))
                    .font(.system(size: 14, weight: .light, design: .rounded))
                    .cornerRadius(20.0)
                    .shadow(radius: 5.0, x: 5, y: 5)
                    .padding(30)
                TextEditor(text: $viewModel.quizDetailsInput)
                    .accessibility(identifier: "quizDetails")
                    .frame(minHeight: 30, alignment: .leading)
                    .background(Color("normalTextField"))
                    .font(.system(size: 14, weight: .light, design: .rounded))
                    .cornerRadius(20.0)
                    .shadow(radius: 5.0, x: 5, y: 5)
                    .foregroundColor(viewModel.quizDetailsInput == viewModel.quizDetailsHintText ? Color("disableFontColor") : Color("fontColor"))
                    .padding(30)
                    .onTapGesture {
                        viewModel.resetTextEditor()
                    }
            //}
            Button(action: { viewModel.buttonTapped() }) {
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
        .previewDevice("iPod touch (7th generation)")
        .preferredColorScheme(.dark)
        CreateQuizView(
            viewModel: CreateQuizViewModel(
                quizWithPIN: QuizWithPIN.default,
                firebaseDataService: FirebaseDataService()
            )
        )
        .previewDevice("iPhone 12 Pro Max")
            
    }
}
