//
//  UserResultsView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/13/20.
//

import SwiftUI

struct UserResultsView: View {
    @ObservedObject var viewModel: UserResultsViewModel

    var body: some View {
        VStack {
            if viewModel.userResults.isEmpty {
                Spacer()
                Text(viewModel.noQuizResultText)
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 30)
                Spacer()
            } else {
                ScrollView {
                    ForEach(viewModel.userResults, id: \.self) { userResult in
                        showUserResultViewContent(userResult)
                            .shadow(color: Color.black.opacity(0.16), radius: 5, x: 0, y: 5)
                            .background(Color.white)
                            .cornerRadius(15)
                            .padding(.all, 10)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .navigationBarTitle(viewModel.headerTitle, displayMode: .inline)
        .frame(maxWidth: .infinity)
        .background(Color("backgroundColor"))
        .overlay(Group {
            if viewModel.showProgressView {
                    ProgressView()
                }
            }
        )
        .onAppear {
            viewModel.fetchAllAttendedQuizzes()
        }
        
    }
    
    func showUserResultViewContent(_ userResult: UserResult) -> AnyView {
        return AnyView(
            VStack {
                Button(action: {
                        viewModel.getScoreBoard(userResult.quizDetails.scoreBoardId)
                }) {
                    HStack {
                        VStack {
                            Text(userResult.quizDetails.title)
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.black)
                                .padding(.horizontal, 30)
                            Text(userResult.quizDetails.quizDetails)
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.black)
                                .padding(.horizontal, 30)
                        }
                        .padding(.vertical, 30)
                        if viewModel.role == .user {
                            Text(String(userResult.score))
                                .font(.system(size: 26, weight: .bold, design: .rounded))
                                .foregroundColor(.black)
                                .padding(.horizontal, 30)
                        }
                            
                    }
                }
                .padding(5)
            }
            .frame(maxWidth: .infinity)
        )
    }
}

struct UserResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewRouter = ViewRouter(currentPage: .userResultsView, nextPage: .resultView)
        let viewModel = UserResultsViewModel(viewRouter: viewRouter, firebaseDataService: FirebaseDataService())
        UserResultsView(viewModel: viewModel)
    }
}
