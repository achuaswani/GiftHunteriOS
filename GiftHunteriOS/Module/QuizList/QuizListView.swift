//
//  QuizListView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/30/20.
//

import SwiftUI

enum QuizState {
    case publish
    case unpublish
}
struct QuizListView: View {
    @ObservedObject var viewModel: QuizListViewModel
    @State var showSheet = false
    @State var edit = false
    @State var add = false
    var body: some View {
        ZStack {
            if viewModel.inactiveQuiz.isEmpty, viewModel.activeQuiz.isEmpty {
                Spacer()
                Text(viewModel.noQuizText)
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 30)
                Spacer()
            } else {
                ScrollView {
                    if !viewModel.inactiveQuiz.isEmpty {
                        showQuizSectionContent(
                            title: viewModel.inactiveTitle,
                            details: viewModel.inactiveQuizDetails,
                            quizArray: viewModel.inactiveQuiz,
                            to: .publish
                        )
                    }
                    if !viewModel.activeQuiz.isEmpty {
                        showQuizSectionContent(
                            title: viewModel.activeTitle,
                            details: viewModel.activeQuizDetails,
                            quizArray: viewModel.activeQuiz,
                            to: .unpublish
                        )
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
                            viewModel.resetQuizData()
                            showSheet = true
                            
                        }
                }
            }
        }
        .navigationBarTitle(viewModel.headerTitle, displayMode: .inline)
        .frame(maxWidth: .infinity)
        .background(Color("backgroundColor"))
        .onAppear {
            viewModel.fetchAllQuizzes()
        }
        .overlay(Group {
            if viewModel.showProgressView {
                    ProgressView()
                }
            }
        )
        .sheet(isPresented: $showSheet, onDismiss: { viewModel.fetchAllQuizzes() }) {
            CreateQuizView(
                viewModel:
                    CreateQuizViewModel(
                        quizWithPIN: viewModel.quizWithPIN,
                        firebaseDataService: viewModel.firebaseDataService
                    )
            )
        }
    }
    
    func showQuizSectionContent(
        title: String,
        details: String,
        quizArray: [QuizWithPIN],
        to state: QuizState
        ) -> some View {
        VStack {
            Text(title)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            Text(details)
                .font(.system(size: 12, weight: .light, design: .rounded))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            ForEach(quizArray, id: \.self) { quizDetails in
                showQuizListItem(quizDetails, state: state)
                    .shadow(color: Color.black.opacity(0.16), radius: 5, x: 0, y: 5)
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.all, 10)
                    .onTapGesture {
                        viewModel.routeToNextPage(quizDetails: quizDetails)
                    }
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    func showQuizListItem(_ quizDetails: QuizWithPIN, state: QuizState) -> some View {
        ZStack {
            VStack {
                Text(quizDetails.quiz.title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .padding(.horizontal, 30)
                Text(quizDetails.quiz.quizDetails)
                    .font(.system(size: 14, weight: .light, design: .rounded))
                    .foregroundColor(.black)
                    .padding(.horizontal, 30)
                    .lineLimit(4)
            }
            VStack(alignment: .trailing) {
                if state == .publish {
                    editIcon(for: quizDetails)
                }
                
                Spacer()
                HStack {
                    Spacer()
                    Text(state == .publish ? viewModel.activateButtonTitle : viewModel.inactivateButtonTitle)
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 35)
                        .background(Color.accentColor)
                        .clipShape(CustomCorner(corners: [.bottomRight], size: 15))
                        .onTapGesture {
                            viewModel.updateQuiz(quizDetails, state)
                        }
                }
            }
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
    }
    
    func editIcon(for quizDetails: QuizWithPIN) -> some View {
        HStack {
            Image(systemName: "pencil.circle.fill")
                .resizable()
                .foregroundColor(.accentColor)
                .frame(width: 30, height: 30, alignment: .top)
                .padding(5)
                .onTapGesture {
                    viewModel.updateQuizWithPIN(quizDetails)
                    showSheet = true
                }
        }
    }
}

struct ActiveQuizView_Previews: PreviewProvider {
    static var previews: some View {
        let viewRouter = ViewRouter(currentPage: .questionsListView)
        QuizListView(viewModel: QuizListViewModel(viewRouter: viewRouter, firebaseDataService: FirebaseDataService()))
    }
}
