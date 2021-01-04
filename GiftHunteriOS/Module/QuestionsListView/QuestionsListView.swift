//
//  QuestionsListView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 1/2/21.
//

import SwiftUI

struct QuestionsListView: View {
    @ObservedObject var viewModel: QuestionsListViewModel
    @State var showSheet = false
    @State var edit = false
    @State var add = false
    var body: some View {
        VStack {
            ZStack {
                if viewModel.questions.isEmpty {
                    Spacer()
                    Text(viewModel.noQuestionsText)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 30)
                    Spacer()
                } else {
                    ScrollView {
                        ForEach(0..<viewModel.questions.count) { index in
                            showQuestionListItem(index: index, question: viewModel.questions[index])
                                .shadow(color: Color.black.opacity(0.16), radius: 5, x: 0, y: 5)
                                .background(Color.white)
                                .cornerRadius(15)
                                .padding(.all, 10)
                        }
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .frame(width: 50, height: 50)
                            .padding()
                            .onTapGesture {
                                showSheet = true
                            }
                    }
                }
            }
            .overlay(Group {
                if viewModel.showProgressView {
                        ProgressView()
                    }
                }
            )
        }
        .navigationBarTitle(viewModel.headerTitle, displayMode: .inline)
        .frame(maxWidth: .infinity)
        .background(Color("backgroundColor"))
        .onAppear {
            viewModel.fetchQuestions()
        }
        .sheet(isPresented: $showSheet, onDismiss: { viewModel.fetchQuestions() }) {
            CreateQuestionsView(
                viewModel: CreateQuestionsViewModel(
                    quizId: viewModel.quizId,
                    questions: viewModel.questions,
                    questionIndex: viewModel.questionIndex,
                    firebaseDataService: viewModel.firebaseDataService
                )
            )
        }
    }
    
    func showQuestionListItem(index: Int, question: Question) -> some View {
        ZStack {
            VStack {
                Text(question.questionText)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .padding(.horizontal, 30)
                ForEach(question.options, id: \.self) { option in
                    Text(option)
                        .font(.system(size: 12, weight: .light, design: .rounded))
                        .foregroundColor(.black)
                        .padding(.horizontal, 30)
                        
                }
                if let answer = Int(question.answer) {
                    Text("Answer: \(question.options[answer])")
                        .font(.system(size: 12, weight: .light, design: .rounded))
                        .foregroundColor(.black)
                        .padding(.horizontal, 30)
                }
            }
            VStack(alignment: .trailing) {
                editIcon(for: question, at: index)
                Spacer()
            }
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
    }
    
    func editIcon(for question: Question, at index: Int) -> some View {
        HStack {
            Spacer()
            Image(systemName: "pencil.circle.fill")
                .resizable()
                .foregroundColor(.accentColor)
                .frame(width: 30, height: 30, alignment: .top)
                .padding(5)
                .onTapGesture {
                    viewModel.updateQuestions(index, question)
                    showSheet = true
                }
        }
    }
}

struct QuestionsListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewRouter = ViewRouter(currentPage: .questionsListView)
        QuestionsListView(viewModel: QuestionsListViewModel(viewRouter: viewRouter, firebaseDataService: FirebaseDataService()))
    }
}
